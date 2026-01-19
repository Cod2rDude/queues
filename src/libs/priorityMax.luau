--!nolint LocalShadow

--[[
    ******************************************************************************
    * @file     : .../src/libs/priorityMax.lua
    * @author   : Cod2rDude
    * @date     : December 27 2025
    * @lastEdit : January 19 2026 @ 16:35
    * @brief    : Priority max queue implementation with binary heap in luau.
    * @version  : 2.0.0
    ******************************************************************************
    * @attention
    *
    * Copyright © 2026 Axon Corporation.
    * All rights reserved.
    *
    * This software is licensed under terms that can be found in the LICENSE file
    * in the root directory of this software component.
    * If no LICENSE file comes with this software, it is provided AS-IS.
    *
    ******************************************************************************
--]]

--// Libs
local types                 = require(script.Parent.global.types)
local swap                  = require(script.Parent.utils.swap)
local swapAndPop            = require(script.Parent.utils.swapAndPop)

--// Constants
local MAX_ITEMS             = 1024
local DEFAULT_QUEUE_SIZE    = 32
local DEFAULT_PRIORITY      = 1

--// Custom Type Definitions/Declerations
type iPriorityMax           = types.priorityMaxQueue
type methods                = {
    __index                 : methods,
    __iter                  : (self : priorityMaxQueue)                                 -> ((priorityMaxQueue, number) -> (number?, any?), priorityMaxQueue, number),
    __len                   : (self : priorityMaxQueue)                                 -> (number),
    __tostring              : (self : priorityMaxQueue)                                 -> (string),
    new                     : (maxItems : number)                                       -> (priorityMaxQueue),
    enqueue                 : (self : priorityMaxQueue, item : any, priority : number)  -> (),
    dequeue                 : (self : priorityMaxQueue)                                 -> (any?),
    peek                    : (self : priorityMaxQueue)                                 -> (any?),
    size                    : (self : priorityMaxQueue)                                 -> (number),
    isEmpty                 : (self : priorityMaxQueue)                                 -> (boolean),
    isFull                  : (self : priorityMaxQueue)                                 -> (boolean),
    clean                   : (self : priorityMaxQueue)                                 -> (),
    fill                    : (self : priorityMaxQueue, item : any, count : number,
                                                        priority : number)              -> (),
    resize                  : (self : priorityMaxQueue, newSize : number)               -> ()
}

--// Functions
function floor(n : number)
    return n // 2
end

--// Lib Decleration
local priorityMaxModule     = {} :: methods

--// Lib Types

--[[
    @object priorityMaxQueue

    @variables
    *   @variable queueTable : { [number] : any } ;; List of items in priority max queue as a binary max heap.
    *   @variable maxItems : number ;; Max items that priority max queue can hold.
    *   @variable currentSize : number ;; Count of items that are currently in priority max queue.
    @methods
    *   @method size    : ()                            -> (number)
    *   @method isEmpty : ()                            -> (boolean)
    *   @method isFull  : ()                            -> (boolean)
    *   @method peek    : ()                            -> (any?)
    *   @method enqueue : (item : any)                  -> ()
    *   @method dequeue : ()                            -> (any?)
    *   @method clean   : ()                            -> ()
    *   @method fill    : (item : any, count : number)  -> ()
    *   @method resize  : (newSize : number)            -> ()
    @metamethods
    *   @metamethod __len
    *   @metamethod __iter
    *   @metamethod __tostring
    @brief A Priority Max queue is a type of queue where each element is in order by their priority
    *       rather than their insertion order. Elements with higher priority are removed first from queue.
    *       This implementation uses a binary max heap which is form of a binary tree. Thus making it easy
    *       to implement using tables.
]]
export type priorityMaxQueue= typeof(setmetatable({} :: iPriorityMax, {} :: typeof(priorityMaxModule)))

--// Lib Variables
priorityMaxModule.__index   = priorityMaxModule

--// Lib Private Functions

--[[
    @notes: See 'https://www.lua.org/pil/7.3.html'
]]
function iter_next(self : priorityMaxQueue, i : number) : (number?, any?)
    i += 1

    if i == 0 then
        return nil
    end

    return i, self:dequeue()
end

--// Lib Constructor

--[[
    @constructor priorityMaxQueue

    @params
    *	@param maxItems : number ;; The maximum number of items the priority max queue can hold.
    @brief Creates a new priority max queue object.
    @returns
    *	@r1 priorityMaxQueue ;; Created priority max queue object.
]]
priorityMaxModule.new       = function(maxItems : number) : priorityMaxQueue
    if not maxItems then maxItems = DEFAULT_QUEUE_SIZE end
    
    maxItems = math.clamp(maxItems, 2, MAX_ITEMS)
    
    local data : iPriorityMax = {
        queueTable          = table.create(maxItems),
        
        maxItems            = maxItems,
        currentSize         = 0
    }
    
    local self = setmetatable(data, priorityMaxModule)

    return self :: priorityMaxQueue
end

--// Lib Methods

--[[
    @method priorityMaxQueue

    @brief Returns the number of items in the priority max queue.
    @returns
    *	@r1 number ;; The number of items in the priority max queue.
]]
function priorityMaxModule:size()
    return self.currentSize
end

--[[
    @method priorityMaxQueue

    @brief Returns true if priority max queue is empty.
    @returns
    *	@r1 boolean
]]
function priorityMaxModule:isEmpty() 
    return self.currentSize == 0
end

--[[
    @method priorityMaxQueue

    @brief Returns true if priority max queue is full.
    @returns
    *	@r1 boolean
]]
function priorityMaxModule:isFull()
    return self.currentSize == self.maxItems
end

--[[
    @method priorityMaxQueue

    @brief Returns the item with highest priority in the priority max queue without removing it.
    @returns
    *	@r1 any ;; The item with highest priority in the priority max queue.
]]
function priorityMaxModule:peek()
    if self:isEmpty() then
        return nil
    end

    return self.queueTable[1][1]
end

--[[
    @method priorityMaxQueue

    @params
    *	@param item : any ;; The item to be added to the priority max queue.
    *	@param priority : number ;; Priority of the item.
    @brief Puts @param item into priority max queue with @param priority.
]]
function priorityMaxModule:enqueue(item : any, priority : number)
    if self:isFull() then
        return
    end
    
    self.currentSize += 1
    
    local newIndex1 = self.currentSize
    self.queueTable[newIndex1] = {item, priority}
    
    -- Sift up
    while newIndex1 > 1
        and self.queueTable[floor(newIndex1)][2] < self.queueTable[newIndex1][2]
    do
        swap(self.queueTable, newIndex1, floor(newIndex1))
        newIndex1 =floor(newIndex1)
    end
end

--[[
    @method priorityMaxQueue

    @brief Removes the item with highest priority in the priority max queue and returns it.
    @returns
    *	@r1 any ;; The removed item.
]]
function priorityMaxModule:dequeue()
    if self:isEmpty() then
        return
    end
    
    local max = swapAndPop(self.queueTable, 1)
    self.currentSize -= 1
    
    if self.currentSize == 0 then
        return max[1]
    end
    
    local index = 1
    
    -- Sift down
    while true do
        local leftIndex = 2 * index
        local rightIndex = leftIndex + 1
        
        local largestPriority = index
        
        if leftIndex <= self.currentSize and self.queueTable[leftIndex][2] > self.queueTable[largestPriority][2] then
            largestPriority = leftIndex
        end
        
        if rightIndex <= self.currentSize and self.queueTable[rightIndex][2] > self.queueTable[largestPriority][2] then
            largestPriority = rightIndex
        end
        
        if largestPriority ~= index then
            swap(self.queueTable, index, largestPriority)
            index = largestPriority
        else
            break
        end
    end
    
    return max[1]
end

--[[
    @method priorityMaxQueue

    @brief Clears the priority max queue.
]]
function priorityMaxModule:clean()
    table.clear(self.queueTable)
    self.currentSize = 0
end

--[[
    @method priorityMaxQueue

    @params
    *   @param item : any ;; The item to fill priority max queue with.
    *   @param count : any ;; Count of fill size.
    @brief Puts @param item to priority max queue @param count times.
    @warning It wipes the old queue completely.
]]
function priorityMaxModule:fill(item : any, count : number, priority : number?)
    count = math.clamp(count, 1, self.maxItems)
    priority = priority or DEFAULT_PRIORITY

    if item == nil then
        return
    end

    self.currentSize = count
    table.clear(self.queueTable)

    for i = 1, count do
        self.queueTable[i] = {item, priority}
    end
end

--[[
    @method priorityMaxQueue

    @params
    * @param newMax : number ;; The new max capacity of the priority max queue.
    @brief Resizes the priority max queue to @param newMax.
]]
function priorityMaxModule:resize(newSize : number)
    newSize = math.max(newSize, 2)

    if newSize == self.maxItems then return end
    if newSize > MAX_ITEMS then newSize = MAX_ITEMS end

    local newQueue = table.create(newSize)
    local itemsToCopyAmount = math.min(newSize, self.currentSize)
    
    local oldQueue = self.queueTable

    table.move(oldQueue, 1, itemsToCopyAmount, 1, newQueue)

    self.currentSize = itemsToCopyAmount
    self.maxItems = newSize
    self.queueTable = newQueue
end

--// Lib Metamethods

--[[
    @metamethod priorityMaxQueue

    @brief Iterator metamethod to allow for loop usage.
    @returns
    * @r1 function ;; The iterator function.
    @notes
    * Iterates logically from highest priority to lowest priority.
]]
function priorityMaxModule:__iter() : ((priorityMaxQueue, number) -> (number?, any?), priorityMaxQueue, number)
    local copied = priorityMaxModule.new(self.maxItems)
    copied.queueTable = table.clone(self.queueTable)
    copied.currentSize = self.currentSize
    return iter_next, copied, 0
end

--[[
    @metamethod priorityMaxQueue

    @brief Returns the number of items in the priority max queue.
    @returns
    *	@r1 number ;; The number of items in the priority max queue.
]]
function priorityMaxModule:__len()
    return self.currentSize
end

--[[
    @metamethod priorityMaxQueue

    @brief Converts priority max queue to a string.
    @returns
    *   @r1 string ;; Generated string.
]]
function priorityMaxModule:__tostring() : string
    return string.format("@priorityMaxQueue<%d/%d><%s>", 
        self.currentSize, self.maxItems,
        tostring(self.queueTable))
end

return priorityMaxModule
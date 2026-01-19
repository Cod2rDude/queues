--!strict

--[[
    ******************************************************************************
    * @file     : .../src/libs/fifo.luau
    * @author   : Cod2rDude
    * @date     : December 24 2025
    * @lastEdit : January 19 2025 @ 15:16
    * @brief    : Fifo queue implementation in luau.
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
local types             = require("./global/types")

--// Constants
local MAX_ITEMS         = 1024
local DEFAULT_QUEUE_SIZE= 32

--// Custom Type Definitions/Declerations
type iFifoQueue         = types.fifoQueue
type methods = {
    __index             : methods,
    __iter              : (self : fifoQueue)                                -> ((fifoQueue, number) -> (number?, any?), fifoQueue, number),
    __len               : (self : fifoQueue)                                -> (number),
    __tostring          : (self : fifoQueue)                                -> (string),
    new                 : (maxItems : number?)                              -> (fifoQueue),
    enqueue             : (self : fifoQueue, item : any)                    -> (),
    dequeue             : (self : fifoQueue)                                -> (any?),
    peek                : (self : fifoQueue)                                -> (any?),
    size                : (self : fifoQueue)                                -> (number),
    isEmpty             : (self : fifoQueue)                                -> (boolean),
    isFull              : (self : fifoQueue)                                -> (boolean),
    clean               : (self : fifoQueue)                                -> (),
    fill                : (self : fifoQueue, item : any, count : number)    -> (),
    resize              : (self : fifoQueue, newSize : number)              -> ()
}

--// Lib Decleration
local fifoModule        = {} :: methods

--// Lib Types

--[[
    @object fifoQueue

    @variables
    *   @variable queueTable : { [number] : any } ;; List of items in queue in order.
    *   @variable head : number ;; Head of queue.
    *   @variable tail : number ;; Tail of queue.
    *   @variable maxItems : number ;; Max items that queue can hold.
    *   @variable currentSize : number ;; Count of items that are currently in queue.
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
    @brief A FIFO (First-In, First-Out) queue is a linear data structure that manages
    *       elements in a strict temporal order, ensuring that the first item added to 
    *       the collection is the first one to be removed.
]]
export type fifoQueue  = typeof(setmetatable({} :: types.fifoQueue, {} :: typeof(fifoModule)))

--// Lib Variables
fifoModule.__index      = fifoModule

--// Lib Private Functions

--[[
    @notes: See 'https://www.lua.org/pil/7.3.html'
]]
function iter_next(self : fifoQueue, i : number) : (number?, any?)
    i += 1

    if i > self.currentSize then
        return nil 
    end

    local lookupIndex = (self.head - 2 + i) % self.maxItems + 1
    return i, self.queueTable[lookupIndex]
end

--// Lib Constructor

--[[
    @constructor fifoQueue

    @params
    *   @param maxItems : number ;; The maximum number of items the queue can hold.
    @brief Creates a new fifo queue object.
    @returns
    *   @r1 fifoQueue ;; Created fifo queue object.
]]
fifoModule.new          = function(maxItems : number?)
    if not maxItems then maxItems = DEFAULT_QUEUE_SIZE end

    local _maxItems = math.clamp(maxItems :: number, 2, MAX_ITEMS) :: number

    local data : iFifoQueue = {
        queueTable      = table.create(_maxItems),

        head            = 1,
        tail            = 0,

        maxItems        = _maxItems,
        currentSize      = 0,
    }

    local self = setmetatable(data, fifoModule)

    return self
end

--// Lib Methods

--[[
    @method fifoQueue

    @brief Returns the number of items in fifo the queue.
    @returns
    *   @r1 number ;; The number of items in the fifo queue.
]]
function fifoModule:size()
    return self.currentSize
end

--[[
    @method fifoQueue

    @brief Returns true if fifo queue is empty.
    @returns
    *   @r1 boolean
]]
function fifoModule:isEmpty()
    return self.currentSize == 0
end

--[[
    @brief Returns true if fifo queue is full.
    @returns
    *   @r1 boolean
]]
function fifoModule:isFull()
    return self.currentSize == self.maxItems
end

--[[
    @method fifoQueue

    @brief Returns the first item in the fifo queue without removing it.
    @returns
    *   @r1 any ;; The first item in the fifo queue.
    @notes
    *   First item is the item at the head of fifo queue.
]]
function fifoModule:peek()
    if self:isEmpty() then
        return nil
    end

    return self.queueTable[self.head]
end

--[[
    @method fifoQueue

    @params
    *   @param item : any ;; The item to be added to fifo queue.
    @brief Puts @param item to tail of fifo queue.
]]
function fifoModule:enqueue(item : any)
    if item == nil then
        return
    end

    if self:isFull() then
        return
    end

    self.tail = (self.tail % self.maxItems) + 1
    self.queueTable[self.tail] = item
    self.currentSize += 1

    return
end

--[[
    @method fifoQueue

    @brief Removes the first item in the fifo queue and returns it.
    @returns
    *   @r1 any? ;; The removed item.
    @notes
    *   First item is the item at the head of fifo queue.
]]
function fifoModule:dequeue()
    if self:isEmpty() then
        return
    end

    local item = self.queueTable[self.head]
    self.queueTable[self.head] = nil
    self.currentSize -= 1
    self.head = (self.head % self.maxItems) + 1

    if self:isEmpty() then
        self.head = 1
        self.tail = 0
    end

    return item
end

--[[
    @method fifoQueue

    @brief Clears the fifo queue.
]]
function fifoModule:clean()
    table.clear(self.queueTable)
    self.head = 1
    self.tail = 0
    self.currentSize = 0
end

--[[
    @method fifoQueue

    @params
    *   @param item : any ;; The item to fill fifo queue with.
    *   @param count : any ;; Count of fill size.
    @brief Puts @param item to fifo queue @param count times.
    @notes See 'https://github.com/luau-lang/luau/issues/172'
]]
function fifoModule:fill(item : any, count : number)
    count = math.clamp(count, 1, self.maxItems)

    if item == nil then
        return
    end

    --[[ -- Don't reallocate.
        self:clean()
        self.currentSize = count
        self.tail = count
        self.queueTable = table.create(count, item)
    ]]

    self.head = 1
    self.tail = count
    self.currentSize = count
    table.clear(self.queueTable)

    for i = 1, count do
        self.queueTable[i] = item
    end
end

--[[
    @method fifoQueue

    @params
    * @param newMax : number ;; The new max capacity of the fifo queue.
    @brief Resizes the fifo queue to @param newMax.
    @notes
    * This is an expensive operation O(n) as it allocates a new table 
    * and linearly copies all existing items to reset the circular logic.
    * If newMax < currentSize, items at the tail are dropped.
    * See 'https://github.com/luau-lang/luau/issues/172'
]]
function fifoModule:resize(newSize : number)
    newSize = math.max(newSize, 2)

    if newSize == self.maxItems then return end
    if newSize > MAX_ITEMS then newSize = MAX_ITEMS end

    local newQueue = table.create(newSize)
    local itemsToCopyAmount = math.min(newSize, self.currentSize)

    local head = self.head
    local oldMax = self.maxItems
    local oldQueue = self.queueTable

    for i = 1, itemsToCopyAmount do
        -- head - 1 + i - 1
        local oldIndex = (head + i - 2) % oldMax + 1
        newQueue[i] = oldQueue[oldIndex]
    end

    self.tail = itemsToCopyAmount
    self.currentSize = itemsToCopyAmount

    self.queueTable = newQueue
    self.head = 1
    self.maxItems = newSize
end

--// Lib Metamethods

--[[
    @metamethod fifoQueue

    @brief Iterator metamethod to allow for loop usage.
    @returns
    * @r1 function ;; The iterator function.
    @notes
    * Iterates logically from head to tail, wrapping around the buffer.
]]
function fifoModule:__iter() : ((fifoQueue, number) -> (number?, any?), fifoQueue, number)
    return iter_next, self, 0
end

--[[
    @metamethod fifoQueue

    @brief Returns the number of items in the fifo queue.
    @returns
    *   @r1 number ;; The number of items in the fifo queue.
]]
function fifoModule:__len() : number
    return self.currentSize
end

--[[
    @metamethod fifoQueue

    @brief Converts fifo queue to a string.
    @returns
    *   @r1 string ;; Generated string.
]]
function fifoModule:__tostring() : string
    return string.format("@fifoQueue<%d/%d><%d-%d><%s>", 
        self.currentSize, self.maxItems,
        self.head, self.tail, tostring(self.queueTable))
end

return fifoModule
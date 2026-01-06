--!nolint LocalShadow

--[[
	******************************************************************************
	* @file		: .../src/libs/priorityMax.lua
	* @author	: Cod2rDude
	* @date		: December 27 2025
	* @lastEdit	: January 6 2026 @ 16:35
	* @brief	: Priority max queue implementation with binary heap in luau.
	* @version	: 1.0.1
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

--[[
	******************************************************************************
	* @todo		: Seperate priorities and items.
	******************************************************************************
]]

--// Libs
local types				= require(script.Parent.global.types)

--// Constants
local MAX_ITEMS			= 512
local DEFAULT_QUEUE_SIZE= 32

--// Custom Type Definitions/Declerations
type i_priority_queue	= types.priorityMax_queue
type methods = {
	__index			: methods,
	enqueue			: (self: priorityMax_queue, item : any, priority : number)	-> (),
	dequeue			: (self: priorityMax_queue)									-> (any),
	peek			: (self: priorityMax_queue)									-> (any),
	size			: (self: priorityMax_queue)									-> (number),
	isEmpty			: (self: priorityMax_queue)									-> (boolean),
	isFull			: (self: priorityMax_queue)									-> (boolean),
	clean			: (self: priorityMax_queue)									-> ()
}

export type priorityMax_queue	= typeof(setmetatable({} :: types.priorityMax_queue, {} :: methods))

--// Functions
function swap(t : {}, i : number, j : number) -- temporary
	t[i], t[j] = t[j], t[i]
end

function swapAndPop(t : {}, i : number) -- temporary
	swap(t, i, #t)
	return table.remove(t)
end

function floor(n : number) -- temporary
	-- return bit32.rshift(n,1) * 2
	return n // 2
end

--// Lib Decleration
local priorityMax_module = {}
priorityMax_module.__index = priorityMax_module

--// Lib Functions

--[[
	@params
	*	@param maxItems : number The maximum number of items the priority max queue can hold.
	@brief Generates a new priority max queue object.
	@returns
	*	@r1 priorityMax_queue Generated priority max queue object.
]]
function priorityMax_module.new(maxItems : number) : priorityMax_queue
	if not maxItems then maxItems = DEFAULT_QUEUE_SIZE end
	
	maxItems = math.clamp(maxItems, 2, MAX_ITEMS)
	
	local data : i_priority_queue = {
		queueTable	= table.create(maxItems),
		
		maxItems	= maxItems,
		currentSize	= 0
	}
	
	local self = setmetatable(data :: i_priority_queue, priorityMax_module)

	return self :: priorityMax_queue
end

--[[
	@brief Returns the number of items in the priority max queue.
	@returns
	*	@r1 number The number of items in the priority max queue.
]]
function priorityMax_module:size()
	local self = self :: priorityMax_queue

	return self.currentSize
end

--[[
	@brief Returns true if priority max queue is empty.
	@returns
	*	@r1 boolean
]]
function priorityMax_module:isEmpty() 
	local self = self :: priorityMax_queue

	return self.currentSize == 0
end

--[[
	@brief Returns true if priority max queue is full.
	@returns
	*	@r1 boolean
]]
function priorityMax_module:isFull()
	local self = self :: priorityMax_queue

	return self.currentSize == self.maxItems
end

--[[
	@brief Returns the item with highest priority in the priority max queue without removing it.
	@returns
	*	@r1 any The item with highest priority in the priority max queue.
]]
function priorityMax_module:peek()
	local self = self :: priorityMax_queue

	if self:isEmpty() then
		return nil
	end

	return self.queueTable[1][1]
end

--[[
	@params
	*	@param item 	: any The item to be added to the priority max queue.
	*	@param priority	: number Priority of the item.
	@brief Puts a new item into priority max queue.
]]
function priorityMax_module:enqueue(item : any, priority : number)
	local self = self :: priorityMax_queue
	
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
	@brief Removes the item with highest priority in the priority max queue and returns it.
	@returns
	*	@r1 any The removed item.
]]
function priorityMax_module:dequeue()
	local self = self :: priorityMax_queue
	
	if self:isEmpty() then
		return nil
	end
	
	--[[
	if self.currentSize == 1 then
		self.currentSize = 0
		return table.remove(self.queueTable)
	end
	
	if self.currentSize == 2 then
		self.currentSize = 1
		return table.remove(self.queueTable, 1)
	end
	--]]
	
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
	@brief Clears the priority max queue.
]]
function priorityMax_module:clean()
	local self = self :: priorityMax_queue
	
	table.clear(self.queueTable)
	self.currentSize = 0
end

return priorityMax_module
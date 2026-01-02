--[[
	******************************************************************************
	* @file		: .../queues/src/libs/fifo.luau
	* @author	: Cod2rDude
	* @date		: December 24 2025
	* @lastEdit	: December 31 2025 @ 16:20
	* @brief	: Fifo queue implementation in luau.
	* @version	: 1.0.6
	******************************************************************************
	* @attention
	*
	* Copyright © 2025 Axon Corporation.
	* All rights reserved.
	*
	* This software is licensed under terms that can be found in the LICENSE file
	* in the root directory of this software component.
	* If no LICENSE file comes with this software, it is provided AS-IS.
	*
	******************************************************************************
--]]

--// Libs
local types				= require(script.Parent.global.types)

--// Constants
local MAX_ITEMS			= 512
local DEFAULT_QUEUE_SIZE= 32

--// Custom Type Definitions/Declerations
type i_fifo_queue		= types.fifo_queue
type methods = {
	__index			: methods,
	enqueue			: (self: fifo_queue, item : any)		-> (boolean?),
	dequeue			: (self: fifo_queue)					-> (any),
	peek			: (self: fifo_queue)					-> (any),
	size			: (self: fifo_queue)					-> (number),
	isEmpty			: (self: fifo_queue)					-> (boolean),
	isFull			: (self: fifo_queue)					-> (boolean),
	clean			: (self: fifo_queue)					-> ()
}

export type fifo_queue	= typeof(setmetatable({} :: types.fifo_queue, {} :: methods))

--// Lib Decleration
local fifo_module = {}
fifo_module.__index = fifo_module

--// Lib Functions

--[[
	@params
	*	@param maxItems : number The maximum number of items the queue can hold.
	@brief Generates a new fifo queue object.
	@returns
	*	@r1 fifo_queue Generated fifo queue object.
]]
function fifo_module.new(maxItems : number) : fifo_queue
	if not maxItems then maxItems = DEFAULT_QUEUE_SIZE end

	maxItems = math.clamp(maxItems, 2, MAX_ITEMS)

	local data : i_fifo_queue = {
		queueTable	= table.create(maxItems),

		head		= 1,
		tail		= 0,

		maxItems	= maxItems,
		currentSize	= 0,
	}

	local self = setmetatable(data :: i_fifo_queue, fifo_module)

	return self :: fifo_queue
end

--[[
	@brief Returns the number of items in the queue.
	@returns
	*	@r1 number The number of items in the queue.
]]
function fifo_module:size()
    local self = self :: fifo_queue

    -- yok amk githubla hesap açıyon
    -- he
    -- sitede zaten extensions için bi yer var ordan direk indirebiliyon otomatik kuryo
    --

	return self.currentSize
end

--[[
	@brief Returns true if queue is empty.
	@returns
	*	@r1 boolean
]]
function fifo_module:isEmpty()
	local self = self :: fifo_queue

	return self.currentSize == 0
end

--[[
	@brief Returns true if queue is full.
	@returns
	*	@r1 boolean
]]
function fifo_module:isFull()
	local self = self :: fifo_queue

	return self.currentSize == self.maxItems
end

--[[
	@brief Returns the first item in the queue without removing it.
	@returns
	*	@r1 any The first item in the queue.
	@notes
	*	First item is the item at the head of queue.
]]
function fifo_module:peek()
	local self = self :: fifo_queue

	if self:isEmpty() then
		return nil
	end

	return self.queueTable[self.head]
end

--[[
	@params
	*	@param item : any The item to be added to the queue.
	@brief Puts a new item in queue.
]]
function fifo_module:enqueue(item : any)
	local self = self :: fifo_queue

	if item == nil then
		return false
	end

	if self:isFull() then
		return false
	end

	self.tail = (self.tail % self.maxItems) + 1
	self.queueTable[self.tail] = item
	self.currentSize += 1
end

--[[
	@brief Removes the first item in the queue and returns it.
	@returns
	*	@r1 any The removed item.
	@notes
	*	First item is the item at the head of queue.
]]
function fifo_module:dequeue()
	local self = self :: fifo_queue

	if self:isEmpty() then
		return false
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
	@brief Clears the queue.
]]
function fifo_module:clean()
	local self = self :: fifo_queue

	table.clear(self.queueTable)
	self.head = 1
	self.tail = 0
	self.currentSize = 0
end

return fifo_module

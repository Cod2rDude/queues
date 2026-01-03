--queues/tests/fifo_test2.luau
--limit test

local function echo(...)
	print("fifo_test2 - " .. ...)
end

return function()
	echo("Starting.")
	
	local fifoLibrary	= require(script.Parent.Parent.libs.fifo) 
	
	local myFifoQueue1	= fifoLibrary.new(1024)
	
	echo("Created a queue with 1024 length.")
	echo("Is my queue size really 1024? "..tostring(myFifoQueue1.maxItems==1024))
	echo("Real queue size: "..myFifoQueue1.maxItems)
	
	local itemsAdded = 0
	while not myFifoQueue1:isFull() do
		myFifoQueue1:enqueue(itemsAdded)
		itemsAdded = itemsAdded + 1
	end
	
	echo("Actually only added "..itemsAdded.." items to queue.")
	
	echo("Done.")
end
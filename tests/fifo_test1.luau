--queues/tests/fifo_test1.luau
--basic enqueue dequeue test

local function echo(...)
	print("fifo_test1 - " .. ...)
end

return function()
	echo("Starting.")
	
	local fifoLibrary	= require(script.Parent.Parent.src.libs.fifo)
	
	local myFifoQueue1	= fifoLibrary.new(32)
	
	for i = 1, 32 do
		myFifoQueue1:enqueue(i)
		echo("Enqueing ".. i)
	end
	
	echo("Enqueue done.")
	echo("Dequeueing...")
	
	repeat
		local item = myFifoQueue1:dequeue()
		echo("Dequeued ".. item)
	until myFifoQueue1:size() == 0
	
	echo("Dequeueing done.")
	
	echo("Trying to add nil.")
	
	local oldSize = myFifoQueue1.currentSize
	
	myFifoQueue1:enqueue(nil)
	
	if myFifoQueue1.currentSize == oldSize then
		echo("We werent able to enqueued nil.")
	else
		echo("We somehow enqueued nil.")
	end
	
	echo("Done.")
end
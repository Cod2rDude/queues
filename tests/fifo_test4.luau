--queues/tests/fifo_test4.luau
--head/tail check

local function echo(...)
	print("fifo_test4 - " .. ...)		
end

return function()
	echo("Starting.")
	
	local fifoLibrary	= require(script.Parent.Parent.libs.fifo)
	
	local myFifoQueue1	= fifoLibrary.new(5)
	
	for i = 1, 5 do
		myFifoQueue1:enqueue(i)
	end
	
	myFifoQueue1:dequeue()
	myFifoQueue1:dequeue()
	
	myFifoQueue1:enqueue(6)
	myFifoQueue1:enqueue(7)
	
	repeat
		local item = myFifoQueue1:dequeue()
		echo("Dequeued ".. item)
	until myFifoQueue1:size() == 0
	-- Should be 3 4 5 6 7
	
	echo("Done.")
end
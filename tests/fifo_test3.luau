--queues/tests/fifo_test3.luau
--garbage test (not really)

local function echo(...)
	print("fifo_test3 - " .. ...)		
end

return function()
	echo("Starting.")
	
	local fifoLibrary	=  require(script.Parent.Parent.libs.fifo)
	
	local myFifoQueue1	= fifoLibrary.new(512)
	
	local someBigAhData	= {table.create(1000)}
	
	echo("Enqueueing big ah data.")
	
	for i = 1, 512 do
		myFifoQueue1:enqueue(someBigAhData)
	end
	
	echo("Enqueued big ah data now cleaning it.")
	
	myFifoQueue1:clean()
	
	echo("Did we really clean up? "..tostring(#myFifoQueue1.queueTable == 0))
	
	echo("Done.")
end
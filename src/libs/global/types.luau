--// Lib Decleration
local types	= {}

--// Lib Types
export type fifo_queue		= 
	{
		queueTable			: { [number] : any };
		
		head				: number,
		tail				: number,
		
		maxItems 			: number,
		currentSize			: number,
	}

export type priorityMax_queue	=
	{
		queueTable			: { [number] : {any | number} };
		
		maxItems 			: number,
		currentSize			: number,
	}

export type priorityMin_queue	=
	{
		queueTable			: { [number] : {any | number} };
		
		maxItems 			: number,
		currentSize			: number,
	}

return types
--// Lib Decleration
local types	= {}

--// Lib Types
export type fifoQueue		= 
	{
		queueTable			: { [number] : any };
		
		head				: number,
		tail				: number,
		
		maxItems 			: number,
		currentSize			: number,
	}

export type priorityMaxQueue	=
	{
		queueTable			: { [number] : {any | number} };
		
		maxItems 			: number,
		currentSize			: number,
	}

return types
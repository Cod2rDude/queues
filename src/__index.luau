--[[
	******************************************************************************
	* @name			:	queues
	* @authors		:	Cod2rDude
	* @date			:	November 24 2025
	* @lastEdit		:	January 6 2025
	* @brief		:	A package containing useful queue implementations.
	* @version		:	1.5.0
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
local libs = script.libs

--queues.src.__index
return {
	fifo		= require(libs.fifo),
	priorityMax	= require(libs.priorityMax),
	priorityMin = require(libs.priorityMin)
}
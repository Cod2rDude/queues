--[[
	******************************************************************************
	* @file		: __log__.lua
	* @author	: Cod2rDude & Scpt2r
	* @date		: April 26 2025
	* @lastEdit	: December 23 2025 @ 20:10
	* @brief	: Customizable logging lib with cache and customization.
	* @version	: 1.2.0
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
local _config				= require(script.Parent._config)
local _messages				= require(script.Parent._messages)

--// Constants
local MAX_CACHE_SIZE		= 128

--// Logs
local cantFindMessageErr	= 0x1
local messageIsntAStringErr	= 0x2
local messageEmptyErr		= 0x3
local errDoesntIncludeLevelErr	= 0x4

--// Functions
function addZeroOn(v)
	if v < 10 then return "0"..tostring(v) end
	return v
end

function getDateAndTime()
	local dt			= DateTime.now():ToUniversalTime()

	local day			= addZeroOn(dt.Day)
	local month			= addZeroOn(dt.Month)
	local year			= dt.Year
	local hour			= (dt.Hour + 3)
	local fixedHour		= addZeroOn(hour)
	local minute		= addZeroOn(dt.Minute)
	local second		= addZeroOn(dt.Second)
	local milliSecond	= addZeroOn(dt.Millisecond)

	return day .. "/" .. month .. "/" .. year,
		fixedHour .. ":" .. minute .. ":" .. second,
		fixedHour .. ":" .. minute .. ":" .. second .. ":" .. milliSecond
end

--// Lib Decleration
local log = {}

--// Lib Variables
log.cache = {}

--// Lib Functions
function log.new(id:number, extra:{string})
	if _messages[id] == nil then log.new(cantFindMessageErr, {"Id:", tostring(id)}) return end
	if extra == {} then extra = "" end

	local baseplate = _config.index .. _config.spacing
	local message = baseplate

	for i, v in pairs(_messages[id].message) do
		if type(v) ~= "string" then log.new(messageIsntAStringErr, {"Message: ", tostring(v)}) continue end

		message = message .. v  .. (i == #_messages[id].message and " " or _config.spacing)
	end

	if message == baseplate then
		log.new(messageEmptyErr, {"Id:", tostring(id)})
		return
	end

	if extra ~= "" then
		for i, v in pairs(extra) do
			message = message .. v .. " "
		end
	end

	message = message .. string.sub(_config.spacing, 2)

	local date, t1me, timeDetailed = getDateAndTime()

	if _config.includeDate then message = message .. date .. " " end
	if _config.includeTime and not _config.includeDetailedTime  then message = message .. t1me .. " " end
	if _config.includeDetailedTime and not _config.includeTime then message = message .. timeDetailed .. " " end

	if _messages[id].type == "log" then
		print(message)
	elseif _messages[id].type == "warning" then
		warn(message)
	elseif _messages[id].type == "error" then
		if _messages[id].level == nil then log.new(errDoesntIncludeLevelErr) return end
		error(message, _messages[id].level)
	end

	table.insert(log.cache, message)

	if #log.cache == MAX_CACHE_SIZE then
		table.clear(log.cache)
	end
end

return log

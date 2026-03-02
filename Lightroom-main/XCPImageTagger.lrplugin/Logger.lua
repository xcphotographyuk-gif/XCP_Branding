--[[----------------------------------------------------------------------------
Logger.lua - Logging utility for XCP Image Tagger
Copyright 2025 XC Photography
------------------------------------------------------------------------------]]

local LrLogger = import "LrLogger"

-- Create the logger
local myLogger = LrLogger("XCPImageTagger")

-- Enable logging to file
myLogger:enable("logfile")

-- Create global logger object with convenience methods
logger = {}

function logger:trace(msg)
    myLogger:trace(msg)
end

function logger:tracef(fmt, ...)
    myLogger:tracef(fmt, ...)
end

function logger:info(msg)
    myLogger:info(msg)
end

function logger:infof(fmt, ...)
    myLogger:infof(fmt, ...)
end

function logger:warn(msg)
    myLogger:warn(msg)
end

function logger:warnf(fmt, ...)
    myLogger:warnf(fmt, ...)
end

function logger:error(msg)
    myLogger:error(msg)
end

function logger:errorf(fmt, ...)
    myLogger:errorf(fmt, ...)
end

function logger:debug(msg)
    myLogger:debug(msg)
end

function logger:debugf(fmt, ...)
    myLogger:debugf(fmt, ...)
end

-- Return the logger for direct access if needed
return myLogger

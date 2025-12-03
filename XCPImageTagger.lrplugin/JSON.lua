--[[----------------------------------------------------------------------------
JSON.lua - JSON Encoder/Decoder for Lightroom
Copyright 2025 XC Photography
------------------------------------------------------------------------------]]

local JSON = {}

-- Escape special characters in strings
local function escapeString(str)
    local escapes = {
        ["\\"] = "\\\\",
        ['"'] = '\\"',
        ["\n"] = "\\n",
        ["\r"] = "\\r",
        ["\t"] = "\\t",
        ["\b"] = "\\b",
        ["\f"] = "\\f",
    }
    return str:gsub('[\\"\n\r\t\b\f]', escapes)
end

-- Encode a Lua value to JSON string
function JSON:encode(value)
    local valueType = type(value)
    
    if value == nil then
        return "null"
    elseif valueType == "boolean" then
        return value and "true" or "false"
    elseif valueType == "number" then
        if value ~= value then -- NaN check
            return "null"
        elseif value == math.huge or value == -math.huge then
            return "null"
        end
        return tostring(value)
    elseif valueType == "string" then
        return '"' .. escapeString(value) .. '"'
    elseif valueType == "table" then
        local result = {}
        local isArray = true
        local maxIndex = 0
        
        -- Check if it's an array
        for k, v in pairs(value) do
            if type(k) ~= "number" or k < 1 or math.floor(k) ~= k then
                isArray = false
                break
            end
            if k > maxIndex then
                maxIndex = k
            end
        end
        
        -- Also check for sparse arrays
        if isArray and maxIndex > 0 then
            for i = 1, maxIndex do
                if value[i] == nil then
                    isArray = false
                    break
                end
            end
        end
        
        if isArray and maxIndex > 0 then
            -- Array
            for i = 1, maxIndex do
                table.insert(result, self:encode(value[i]))
            end
            return "[" .. table.concat(result, ",") .. "]"
        elseif next(value) == nil then
            -- Empty table - return empty object
            return "{}"
        else
            -- Object
            for k, v in pairs(value) do
                local key = type(k) == "string" and k or tostring(k)
                table.insert(result, '"' .. escapeString(key) .. '":' .. self:encode(v))
            end
            return "{" .. table.concat(result, ",") .. "}"
        end
    else
        return "null"
    end
end

-- Decode JSON string to Lua value
function JSON:decode(str)
    if not str or str == "" then
        return nil
    end
    
    local pos = 1
    local len = #str
    
    local function skipWhitespace()
        while pos <= len do
            local c = str:sub(pos, pos)
            if c == " " or c == "\t" or c == "\n" or c == "\r" then
                pos = pos + 1
            else
                break
            end
        end
    end
    
    local function parseValue()
        skipWhitespace()
        if pos > len then return nil end
        
        local c = str:sub(pos, pos)
        
        if c == '"' then
            return parseString()
        elseif c == '{' then
            return parseObject()
        elseif c == '[' then
            return parseArray()
        elseif c == 't' then
            if str:sub(pos, pos + 3) == "true" then
                pos = pos + 4
                return true
            end
        elseif c == 'f' then
            if str:sub(pos, pos + 4) == "false" then
                pos = pos + 5
                return false
            end
        elseif c == 'n' then
            if str:sub(pos, pos + 3) == "null" then
                pos = pos + 4
                return nil
            end
        elseif c == '-' or (c >= '0' and c <= '9') then
            return parseNumber()
        end
        
        return nil
    end
    
    function parseString()
        pos = pos + 1 -- skip opening quote
        local result = ""
        
        while pos <= len do
            local c = str:sub(pos, pos)
            
            if c == '"' then
                pos = pos + 1
                return result
            elseif c == '\\' then
                pos = pos + 1
                local escaped = str:sub(pos, pos)
                if escaped == 'n' then
                    result = result .. "\n"
                elseif escaped == 'r' then
                    result = result .. "\r"
                elseif escaped == 't' then
                    result = result .. "\t"
                elseif escaped == 'b' then
                    result = result .. "\b"
                elseif escaped == 'f' then
                    result = result .. "\f"
                elseif escaped == 'u' then
                    -- Unicode escape
                    local hex = str:sub(pos + 1, pos + 4)
                    local code = tonumber(hex, 16)
                    if code then
                        if code < 128 then
                            result = result .. string.char(code)
                        else
                            -- Simple UTF-8 encoding for common cases
                            result = result .. "?"
                        end
                    end
                    pos = pos + 4
                else
                    result = result .. escaped
                end
                pos = pos + 1
            else
                result = result .. c
                pos = pos + 1
            end
        end
        
        return result
    end
    
    function parseNumber()
        local startPos = pos
        
        -- Optional minus
        if str:sub(pos, pos) == '-' then
            pos = pos + 1
        end
        
        -- Integer part
        while pos <= len and str:sub(pos, pos):match("[0-9]") do
            pos = pos + 1
        end
        
        -- Decimal part
        if pos <= len and str:sub(pos, pos) == '.' then
            pos = pos + 1
            while pos <= len and str:sub(pos, pos):match("[0-9]") do
                pos = pos + 1
            end
        end
        
        -- Exponent part
        local c = str:sub(pos, pos)
        if c == 'e' or c == 'E' then
            pos = pos + 1
            c = str:sub(pos, pos)
            if c == '+' or c == '-' then
                pos = pos + 1
            end
            while pos <= len and str:sub(pos, pos):match("[0-9]") do
                pos = pos + 1
            end
        end
        
        return tonumber(str:sub(startPos, pos - 1))
    end
    
    function parseArray()
        pos = pos + 1 -- skip opening bracket
        local result = {}
        
        skipWhitespace()
        
        if str:sub(pos, pos) == ']' then
            pos = pos + 1
            return result
        end
        
        while pos <= len do
            local value = parseValue()
            table.insert(result, value)
            
            skipWhitespace()
            local c = str:sub(pos, pos)
            
            if c == ']' then
                pos = pos + 1
                return result
            elseif c == ',' then
                pos = pos + 1
            else
                break
            end
        end
        
        return result
    end
    
    function parseObject()
        pos = pos + 1 -- skip opening brace
        local result = {}
        
        skipWhitespace()
        
        if str:sub(pos, pos) == '}' then
            pos = pos + 1
            return result
        end
        
        while pos <= len do
            skipWhitespace()
            
            -- Parse key
            if str:sub(pos, pos) ~= '"' then
                break
            end
            
            local key = parseString()
            
            skipWhitespace()
            
            -- Expect colon
            if str:sub(pos, pos) ~= ':' then
                break
            end
            pos = pos + 1
            
            -- Parse value
            local value = parseValue()
            result[key] = value
            
            skipWhitespace()
            local c = str:sub(pos, pos)
            
            if c == '}' then
                pos = pos + 1
                return result
            elseif c == ',' then
                pos = pos + 1
            else
                break
            end
        end
        
        return result
    end
    
    return parseValue()
end

return JSON

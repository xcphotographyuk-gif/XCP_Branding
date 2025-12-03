--[[----------------------------------------------------------------------------
XCP Platform Publisher - Utility Functions
Copyright 2025 XC Photography

Common utility functions for the plugin, inspired by proven Lightroom patterns.
------------------------------------------------------------------------------]]

local LrApplication = import 'LrApplication'
local LrTasks = import 'LrTasks'
local LrDialogs = import 'LrDialogs'
local LrFunctionContext = import 'LrFunctionContext'
local LrStringUtils = import 'LrStringUtils'

local Util = {}

-- ============================================================================
-- ARRAY UTILITIES
-- ============================================================================

-- Insert element into array at position
function Util.arrayInsert(t, pos, value)
    if value == nil then
        value = pos
        pos = #t + 1
    end
    table.insert(t, pos, value)
    return t
end

-- Map function over array
function Util.arrayMap(t, func)
    local result = {}
    for i, v in ipairs(t) do
        result[i] = func(v, i)
    end
    return result
end

-- Reduce array to single value
function Util.arrayReduce(t, initialValue, func)
    local result = initialValue
    for k, v in ipairs(t) do
        result = func(result, v, k)
    end
    return result
end

-- Filter array by predicate function
function Util.arrayFilter(t, func)
    local result = {}
    for k, v in ipairs(t) do
        if func(v, k) then
            table.insert(result, v)
        end
    end
    return result
end

-- Check if array contains value
function Util.arrayContains(t, value, func)
    for k, v in ipairs(t) do
        if func then
            if func(v) then return true end
        else
            if v == value then return true end
        end
    end
    return false
end

-- Append arrays together
function Util.arrayAppend(...)
    local result = {}
    local args = {...}
    for i = 1, select('#', ...) do
        local a = args[i]
        if a then
            for _, v in ipairs(a) do
                table.insert(result, v)
            end
        end
    end
    return result
end

-- Copy array (shallow)
function Util.arrayCopy(t)
    local result = {}
    for i, v in ipairs(t) do
        result[i] = v
    end
    return result
end

-- Reverse array
function Util.arrayReverse(t)
    local i, j = 1, #t
    while i < j do
        t[i], t[j] = t[j], t[i]
        i = i + 1
        j = j - 1
    end
    return t
end

-- ============================================================================
-- TABLE UTILITIES
-- ============================================================================

-- Reduce table (key-value pairs) to single value
function Util.tableReduce(t, initialValue, func)
    local result = initialValue
    for k, v in pairs(t) do
        result = func(result, v, k)
    end
    return result
end

-- Shallow copy of table
function Util.tableCopy(t)
    local result = {}
    for k, v in pairs(t) do
        result[k] = v
    end
    return result
end

-- Deep copy of table
function Util.tableDeepCopy(t)
    if type(t) ~= 'table' then return t end
    local result = {}
    for k, v in pairs(t) do
        result[Util.tableDeepCopy(k)] = Util.tableDeepCopy(v)
    end
    return result
end

-- Merge tables (second overwrites first)
function Util.tableMerge(t1, t2)
    local result = Util.tableCopy(t1)
    for k, v in pairs(t2 or {}) do
        result[k] = v
    end
    return result
end

-- ============================================================================
-- STRING UTILITIES
-- ============================================================================

-- Trim whitespace from string
function Util.trim(s)
    if not s then return '' end
    return LrStringUtils.trimWhitespace(s)
end

-- Pluralize word based on count
function Util.plural(count, singular, plural_form)
    plural_form = plural_form or (singular .. 's')
    if count == 1 then
        return singular
    else
        return plural_form
    end
end

-- Format string with count and plural
function Util.formatPlural(count, singular, plural_form)
    return string.format('%d %s', count, Util.plural(count, singular, plural_form))
end

-- Split string by delimiter
function Util.split(str, delimiter)
    local result = {}
    local pattern = string.format('([^%s]+)', delimiter)
    for match in string.gmatch(str, pattern) do
        table.insert(result, Util.trim(match))
    end
    return result
end

-- Join array with delimiter
function Util.join(t, delimiter)
    return table.concat(t, delimiter)
end

-- ============================================================================
-- ERROR HANDLING
-- ============================================================================

-- Show errors with context
function Util.showErrors(func, context)
    context = context or 'Operation'
    local success, result = LrTasks.pcall(func)
    if not success then
        LrDialogs.message(
            context .. ' Error',
            'An error occurred: ' .. tostring(result),
            'critical'
        )
        return nil, result
    end
    return result
end

-- Wrap function with error handling
function Util.wrapWithErrors(func, context)
    return function(...)
        local args = {...}
        return Util.showErrors(function()
            return func(unpack(args))
        end, context)
    end
end

-- ============================================================================
-- CATALOG UTILITIES
-- ============================================================================

-- Get active catalog
function Util.getCatalog()
    return LrApplication.activeCatalog()
end

-- Get selected photos
function Util.getSelectedPhotos()
    local catalog = Util.getCatalog()
    return catalog:getTargetPhotos()
end

-- Batch get raw metadata for photos
function Util.batchGetMetadata(photos, fields)
    if not photos or #photos == 0 then return {} end
    
    local catalog = Util.getCatalog()
    local results = {}
    
    for i, photo in ipairs(photos) do
        results[i] = {}
        for _, field in ipairs(fields) do
            results[i][field] = photo:getFormattedMetadata(field) or ''
        end
    end
    
    return results
end

-- Safe write access to catalog
function Util.withWriteAccess(actionName, func)
    local catalog = Util.getCatalog()
    local success, result
    
    catalog:withWriteAccessDo(actionName, function()
        success, result = pcall(func)
    end)
    
    if not success then
        LrDialogs.message('Write Error', 'Failed to write to catalog: ' .. tostring(result), 'critical')
        return nil, result
    end
    
    return result
end

-- ============================================================================
-- ASYNC UTILITIES
-- ============================================================================

-- Start async task with context
function Util.startAsyncTask(func, context)
    LrTasks.startAsyncTask(function()
        LrFunctionContext.callWithContext(context or 'asyncTask', function(ctx)
            local success, err = LrTasks.pcall(func, ctx)
            if not success then
                LrDialogs.message('Task Error', 'An error occurred: ' .. tostring(err), 'critical')
            end
        end)
    end)
end

-- Post async task with context (runs after current task completes)
function Util.postAsyncTask(func, context)
    LrTasks.startAsyncTask(function()
        LrTasks.yield()  -- Let current task complete
        LrFunctionContext.callWithContext(context or 'postAsyncTask', function(ctx)
            local success, err = LrTasks.pcall(func, ctx)
            if not success then
                LrDialogs.message('Task Error', 'An error occurred: ' .. tostring(err), 'critical')
            end
        end)
    end)
end

-- ============================================================================
-- PHOTO UTILITIES
-- ============================================================================

-- Check if photo is available (not missing or video)
function Util.isPhotoAvailable(photo)
    local fileFormat = photo:getFormattedMetadata('fileFormat')
    if fileFormat == 'VIDEO' then
        return false, 'video'
    end
    
    local smartPreviewInfo = photo:getRawMetadata('smartPreviewInfo')
    if smartPreviewInfo and smartPreviewInfo.smartPreviewPath then
        return true, 'smartPreview'
    end
    
    local path = photo:getRawMetadata('path')
    if not path or path == '' then
        return false, 'missing'
    end
    
    return true, 'available'
end

-- Filter photos to only available ones
function Util.filterAvailablePhotos(photos)
    local available = {}
    local missing = {}
    local videos = {}
    
    for _, photo in ipairs(photos) do
        local isAvailable, reason = Util.isPhotoAvailable(photo)
        if isAvailable then
            table.insert(available, photo)
        elseif reason == 'video' then
            table.insert(videos, photo)
        else
            table.insert(missing, photo)
        end
    end
    
    return available, missing, videos
end

-- Get photo file info
function Util.getPhotoInfo(photo)
    return {
        fileName = photo:getFormattedMetadata('fileName') or '',
        fileFormat = photo:getFormattedMetadata('fileFormat') or '',
        dimensions = photo:getFormattedMetadata('dimensions') or '',
        rating = photo:getRawMetadata('rating') or 0,
        colorLabel = photo:getRawMetadata('colorNameForLabel') or '',
        path = photo:getRawMetadata('path') or '',
    }
end

-- ============================================================================
-- KEYWORD UTILITIES
-- ============================================================================

-- Create keyword if it doesn't exist
function Util.createKeyword(catalog, keywordName, parentKeyword)
    if not keywordName or keywordName == '' then return nil end
    
    local keyword = catalog:createKeyword(keywordName, {}, true, parentKeyword, true)
    return keyword
end

-- Add keywords to photo
function Util.addKeywordsToPhoto(photo, keywords, catalog)
    catalog = catalog or Util.getCatalog()
    
    for _, kwName in ipairs(keywords) do
        if kwName and kwName ~= '' then
            local keyword = Util.createKeyword(catalog, kwName)
            if keyword then
                photo:addKeyword(keyword)
            end
        end
    end
end

-- Get photo keywords as array of strings
function Util.getPhotoKeywords(photo)
    local keywords = photo:getRawMetadata('keywords') or {}
    local result = {}
    
    for _, kw in ipairs(keywords) do
        local name = kw:getName()
        if name and name ~= '' then
            table.insert(result, name)
        end
    end
    
    return result
end

-- ============================================================================
-- COLLECTION UTILITIES
-- ============================================================================

-- Get photo collections as array of names
function Util.getPhotoCollections(photo)
    local collections = photo:getContainedCollections() or {}
    local result = {}
    
    for _, collection in ipairs(collections) do
        local name = collection:getName()
        if name and name ~= '' then
            table.insert(result, name)
        end
    end
    
    return result
end

return Util

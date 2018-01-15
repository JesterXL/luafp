local object = {}

local predicates = require './src/predicates'
local func = require('./src/func')

local function splitString(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            t[i] = str
            i = i + 1
    end
    return t
end

local function hasDots(path)
    if predicates.isString(path) == false then
        return false, 'path is not a string'
    end
    local startIndex = string.find(path, '%.')
    return predicates.isNumber(startIndex)
end

-- TODO: make more verbose, perhaps splitting and checking
-- first and last character to be [ and ], including middle
-- to be a number. For now, just checking [.
local function containsArrayAccessor(path)
    if predicates.isString(path) == false then
        return false, 'path is not a string'
    end
    local startIndex = string.find(path, '%[')
    return predicates.isNumber(startIndex)
end

local function getPathAndArrayAccessor(path)
    local startIndex = string.find(path, '%[')
    local mainPath = string.sub(path, 1, startIndex - 1)
    local arrayAccessor = string.sub(path, startIndex, string.len(path))
    arrayAccessor = string.sub(arrayAccessor, 2, string.len(arrayAccessor))
    arrayAccessor = string.sub(arrayAccessor, 1, string.len(arrayAccessor) - 1)
    arrayAccessor = tonumber(arrayAccessor, 10)
    return mainPath, arrayAccessor
end

local function dig(paths, object)
    local holder = object
    for i, v in ipairs(paths) do
        if containsArrayAccessor(v) == false then
            holder = holder[v]
        else
            local sPath, aAccess = getPathAndArrayAccessor(v)
            holder = holder[sPath][aAccess]
        end
    end
    return holder
end

local function has(property, o)
    if predicates.isString(property) == false then
        return false, 'property is not a string, so nothing to check for'
    end
    if predicates.isNil(o) == true then
        return false, 'o is nil, so nothing to check for'
    end
    if hasDots(property) == true then
        local parsedPath = splitString(property, '.')
        local result, valueOrError = pcall(dig, parsedPath, o)
        if result == true then
            return predicates.exists(valueOrError) == true
        else
            return nil
        end
    else
        return predicates.exists(o[property]) == true
    end
end

local function get(property, o)
    if predicates.isString(property) == false then
        return nil, 'property is not a string, so nothing to get'
    end
    if predicates.isNil(o) == true then
        return nil, 'o is nil, so nothing to get'
    end
    if hasDots(property) == true then
        local parsedPath = splitString(property, '.')
        local result, valueOrError = pcall(dig, parsedPath, o)
        if result == true then
            return valueOrError
        else
            return nil
        end
    else
        return o[property]
    end
end

local function getOr(defaultValue, property, o)
    if predicates.isString(property) == false then
        return defaultValue, 'property is not a string, so nothing to get'
    end
    if predicates.isNil(o) == true then
        return defaultValue, 'o is nil, so nothing to get'
    end
    if hasDots(property) == true then
        local parsedPath = splitString(property, '.')
        local result, valueOrError = pcall(dig, parsedPath, o)
        if result == true then
            if predicates.exists(valueOrError) then
                return valueOrError
            else
                return defaultValue
            end
        else
            return defaultValue
        end
    else
        if predicates.exists(o[property]) then
            return o[property]
        else
            return defaultValue
        end
    end
end

object.has = func.curry(2, has)
object.get = func.curry(2, get)
object.getOr = func.curry(3, getOr)

return object
--- Lua FP object module.
-- @module luafp.object
-- @alias object
local object = {}

local predicates = require 'luafp.predicates'
local func = require 'luafp.func'

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

--- Checks to see if a table has a path name. This is for tables, not classes enabled via metatables.
-- @param path string name of the property
-- @param o table that might contain the property name
-- @return yesOrNo true if it found it, false if it was nil
-- @return error String error message if parameter validation failed
-- @usage local has = require 'luafp.object'.has
-- turtle = {firstName: 'Raphael', weapon: 'Sai'}
-- print(has('weapon', turtle) -- true
function object.has(path, o)
    if predicates.isString(path) == false then
        return false, 'path is not a string, so nothing to check for'
    end
    if predicates.isNil(o) == true then
        return false, 'o is nil, so nothing to check for'
    end
    if hasDots(path) == true then
        local parsedPath = splitString(path, '.')
        local result, valueOrError = pcall(dig, parsedPath, o)
        if result == true then
            return predicates.exists(valueOrError) == true
        else
            return nil
        end
    else
        return predicates.exists(o[path]) == true
    end
end

--- Gets the value of the object from the path, else nil. Supports property names and array indexes separated by dots.
-- @see getOr
-- @param path string name of the path
-- @param o table that might contain the path name
-- @return value value found at the path, else nil
-- @return error String error message if parameter validation failed
-- @usage local has = require 'luafp.object'.has
-- turtle = {
--     firstName = 'Raphael', 
--     type = {
--         name = 'ninja',
--         weapons = {
--             {
--                 name = 'Sai',
--                 damage = 4
--             },
--             {
--                 name = 'Fist',
--                 damage = 2
--             }
--         }
--     }
-- }
-- print(get('type.weapons[1].damage')(turtle)) -- 4
function object.get(path, o)
    if predicates.isString(path) == false then
        return nil, 'path is not a string, so nothing to get'
    end
    if predicates.isNil(o) == true then
        return nil, 'o is nil, so nothing to get'
    end
    if hasDots(path) == true then
        local parsedPath = splitString(path, '.')
        local result, valueOrError = pcall(dig, parsedPath, o)
        if result == true then
            return valueOrError
        else
            return nil
        end
    else
        return o[path]
    end
end


--- Gets the value of the object from the path, else returns the default value. Supports property names and array indexes separated by dots. Like get, except it provides a default vs. nil
-- @see get
-- @param defaultValue value you want returned if nil is found at the path
-- @param path string name of the path
-- @param o table that might contain the path name
-- @return value value found at the path, else your provided defaultValue
-- @return error String error message if parameter validation failed
-- @usage local getOr = require 'luafp.object'.getOr
-- turtle = {
--     firstName = 'Raphael', 
--     type = {
--         name = 'ninja',
--         weapons = {
--             {
--                 name = 'Sai',
--                 damage = 4
--             },
--             {
--                 name = 'Fist',
--                 damage = 2
--             }
--         }
--     }
-- }
-- print(getOr(0)('type.weapons[3].damage')(turtle)) -- 0
function object.getOr(defaultValue, path, o)
    if predicates.isString(path) == false then
        return defaultValue, 'path is not a string, so nothing to get'
    end
    if predicates.isNil(o) == true then
        return defaultValue, 'o is nil, so nothing to get'
    end
    if hasDots(path) == true then
        local parsedPath = splitString(path, '.')
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
        if predicates.exists(o[path]) then
            return o[path]
        else
            return defaultValue
        end
    end
end

object.has = func.curry(object.has)
object.get = func.curry(object.get)
object.getOr = func.curry(object.getOr)

return object
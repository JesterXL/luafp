--- Lua FP array module
-- @module luaFP.array
-- @alias array
local array = {}

local predicates = require "luafp.predicates"
local func = require "luafp.func"

-- TODO/FIXME: this is duplicated in Collection.lua for now as well
local function length(list)
    if predicates.isTable(list) == false then
        return 0, 'list is not a table'
    end
    local count = 0
    for _ in pairs(list) do count = count + 1 end
    return count
end


--- Searchs the list for your value, and if it finds it, it returns the index.
-- @param fromIndex Starting list index to search from
-- @param value Value you wish to look for in the list
-- @param list List you wish to search through
-- @return index 0 or above if it found it, -1 if it did not
-- @return error String error message if parameter validation failed
-- @usage local list = require 'luaFP'.list
-- names = {'Jesse', 'Brandy', 'Cow'}
-- cowIndex = list.indexOf(1, 'Cow', names)
-- print(cowIndex) -- 3
function array.indexOf(fromIndex, value, list)
    if predicates.isNumber(fromIndex) == false then
        return -1, 'fromIndex is not a number'
    end
    if predicates.isTable(list) == false then
        return -1, 'list is not a table'
    end
    for i, v in ipairs(list) do
        if i >= fromIndex then
            if v == value then
                return i
            end
        end
    end
    return -1
end

--- Searchs the list for your value using the predicate function you provide, and if the predicate function returns true, it returns the index.
-- @param fromIndex Starting list index to search from
-- @param func predicate function that takes the item from the table, expected to return true if your function thinks it found a match, false otherwise.
-- @param list List you wish to search through
-- @return index 0 or above if it found it, -1 if it did not
-- @return error String error message if parameter validation failed
-- @usage local list = require 'luaFP'.list
-- names = {'Jesse', 'Brandy', 'Cow'}
-- isCow = function(o) return o == 'Cow' end
-- cowIndex = list.fromIndex(1, isCow, names)
-- print(cowIndex) -- 3
function array.findIndex(fromIndex, func, list)
    if predicates.isNumber(fromIndex) == false then
        return -1, 'fromIndex is not a number'
    end
    if predicates.isFunction(func) == false then
        return -1, 'func is not a function'
    end
    if predicates.isTable(list) == false then
        return -1, 'list is not a table'
    end
    for i, v in ipairs(list) do
        if i >= fromIndex then
            if func(v) == true then
                return i
            end
        end
    end
    return -1
end


--- Searchs the list for your value using the predicate function you provide, and if the predicate function returns true, it returns the item
-- @param fromIndex Starting list index to search from
-- @param func predicate function that takes the item from the table, expected to return true if your function thinks it found a match, false otherwise.
-- @param list List you wish to search through
-- @return value The item in the list that was found, else nil
-- @return error String error message if parameter validation failed
-- @usage local list = require 'luaFP'.list
-- names = {'Jesse', 'Brandy', 'Cow'}
-- isCow = function(o) return o == 'Cow' end
-- cow = list.find(1, isCow, names)
-- print(cow) -- Cow
function array.find(fromIndex, func, list)
    if predicates.isNumber(fromIndex) == false then
        return nil, 'fromIndex is not a number'
    end
    if predicates.isFunction(func) == false then
        return nil, 'func is not a function'
    end
    if predicates.isTable(list) == false then
        return nil, 'list is not a table'
    end
    for i, v in ipairs(list) do
        if i >= fromIndex then
            if func(v) == true then
                return v
            end
        end
    end
    return nil
end


--- Gets the first item of the list
-- @param list List you want the 1st item from
-- @return value First item in the list, else nil
-- @return error String error message if parameter validation failed
-- @usage local list = require 'luaFP'.list
-- names = {'Jesse', 'Brandy', 'Cow'}
-- print(list.head(names)) -- Jesse
function array.head(list)
    if predicates.isTable(list) == false then
        return nil, 'list is not a table'
    end
    return list[1]
end

--- Gets the last item of the list
-- @param list List you want the last item from
-- @return value Last item in the list, else nil
-- @return error String error message if parameter validation failed
-- @usage local list = require 'luaFP'.list
-- names = {'Jesse', 'Brandy', 'Cow'}
-- print(list.last(names)) -- Cow
function array.last(list)
    if predicates.isTable(list) == false then
        return nil, 'list is not a table'
    end
    local len = length(list)
    return list[len]
end

--- Gets all but the first item of the list
-- @param list List you want the tail from
-- @return value tail of the list, else nil
-- @return error String error message if parameter validation failed
-- @usage local list = require 'luaFP'.list
-- names = {'Jesse', 'Brandy', 'Cow'}
-- print(list.tail(names)) -- {'Brandy', 'Cow'}
function array.tail(list)
    if predicates.isTable(list) == false then
        return nil, 'list is not a table'
    end

    if length(list) > 1 then
        local cloned = {table.unpack(list)}
        table.remove(cloned, 1)
        return cloned
    else
        return {}
    end
end

--- Gets all but the last item of the list
-- @param list List you want the initial from
-- @return value initial of the list, else nil
-- @return error String error message if parameter validation failed
-- @usage local list = require 'luaFP'.list
-- names = {'Jesse', 'Brandy', 'Cow'}
-- print(list.initial(names)) -- {'Jesse', 'Brandy'}
function array.initial(list)
    if predicates.isTable(list) == false then
        return nil, 'list is not a table'
    end
    local listLength = length(list)
    if listLength > 1 then
        local cloned = {table.unpack(list)}
        table.remove(cloned, listLength)
        return cloned
    else
        return {}
    end
end

--- Gets the difference between in the 2 lists, and gives you a list containing the differences.
-- @param list First list to compare
-- @param values Second list to compare against the first
-- @return differences A new list containing the differences
-- @return error String error message if parameter validation failed
-- @usage local list = require 'luaFP'.list
-- names = {'Jesse', 'Brandy', 'Cow'}
-- wat = {'Cow'}
-- print(list.difference2(names, wat)) -- {'Jesse', 'Brandy'}
function array.difference2(list, values)
    if predicates.isTable(list) == false then
        return nil, 'list is not a table'
    end
    if predicates.isTable(values) == false then
        return nil, 'values is not a table'
    end

    local included = {}
    for i, v in ipairs(list) do
        local foundIndex = array.findIndex(0)(function(item) return item == v end)(values)
        if foundIndex == -1 then
            table.insert(included, v)
        end
    end
    return included
end

--- Fills a table with values
-- @warning Mutates the list you pass in
-- @param value Value you want to prepopulate in your list; cannot be nil
-- @param startIndex index to start insert your value
-- @param endIndex last index to stop inserting your value
-- @param list you want to insert values into
-- @return filled Your mutated list with values in it
-- @return error String error message if parameter validation failed
-- @usage local list = require 'luaFP'.list
-- SpiceGirls = {}
-- print(list.file('ziggyZigAh', 1, 3, SpiceGirls)) -- {'ziggyZigAh', 'ziggyZigAh', 'ziggyZigAh'}
function array.fill(value, startIndex, endIndex, list)
    if predicates.isNil(value) == true then
        return nil, 'you cannot fill a Lua table with a bunch of nils as the last item to have nil is considered the end'
    end
    if predicates.isNumber(startIndex) == false then
        return nil, 'startIndex is not a number'
    end
    if predicates.isNumber(endIndex) == false then
        return nil, 'endIndex is not a number'
    end
    if predicates.isTable(list) == false then
        return nil, 'list is not a table'
    end

    for i=startIndex,endIndex,1 do
        
        list[i] = value
    end
    return list
end

-- TODO: it mutates, ugh...
local function insertABunch(list, items)
    for i, v in ipairs(items) do
        table.insert(list, v)
    end
    return list
end


--- Flattens a table 1 level by unpacking the table and inserting where it found it.
-- @param list list which contains other list you wish to flatten
-- @return flattened List with 1 level of flattening done
-- @return error String error message if parameter validation failed
-- @usage local flatten = require 'luaFP'.flatten
-- peeps = { {'Jesse', 'Dat Lightning'}, {'Cow', 'Cheese'} }
-- print(flatten(peeps) -- {'Jesse', 'Dat Lightning', 'Cow', 'Cheese'}
function array.flatten(list)
    if predicates.isTable(list) == false then
        return nil, 'you cannot flatten a nil value, list is not a table'
    end

    local flatterErf = {}
    for i, v in ipairs(list) do
        if predicates.isTable(v) == true then
            insertABunch(flatterErf, v)
        else
            table.insert(flatterErf, v)
        end
    end
    return flatterErf
end

array.indexOf = func.curry(array.indexOf)
array.findIndex = func.curry(array.findIndex)
array.find = func.curry(array.find)
array.difference2 = func.curry(array.difference2)
array.fill = func.curry(array.fill)

return array
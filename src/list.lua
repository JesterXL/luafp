local list = {}

local predicates = require "./src/predicates"
local func = require "./src/func"

-- TODO/FIXME: this is duplicated in Collection.lua for now as well
local function length(list)
    if predicates.isTable(list) == false then
        return 0, 'list is not a table'
    end
    local count = 0
    for _ in pairs(list) do count = count + 1 end
    return count
end

function indexOf(fromIndex, value, list)
    if predicates.isNumber(fromIndex) == false then
        return -1, 'fromIndex is not a number'
    end
    if predicates.isTable(list) == false then
        return -1, 'list is not a table'
    end
    -- TODO: figure out from index, assume 0 for now
    fromIndex = 0
    for i, v in ipairs(list) do
        if v == value then
            return i
        end
    end
    return -1
end

function findIndex(fromIndex, func, list)
    if predicates.isNumber(fromIndex) == false then
        return -1, 'fromIndex is not a number'
    end
    if predicates.isFunction(func) == false then
        return -1, 'func is not a function'
    end
    if predicates.isTable(list) == false then
        return -1, 'list is not a table'
    end
    -- TODO: figure out from index, assume 0 for now
    fromIndex = 0
    for i, v in ipairs(list) do
        if func(v) == true then
            return i
        end
    end
    return -1
end


function find(fromIndex, func, list)
    if predicates.isNumber(fromIndex) == false then
        return -1, 'fromIndex is not a number'
    end
    if predicates.isFunction(func) == false then
        return -1, 'func is not a function'
    end
    if predicates.isTable(list) == false then
        return -1, 'list is not a table'
    end
    -- TODO: figure out from index, assume 0 for now
    fromIndex = 0
    for i, v in ipairs(list) do
        if func(v) == true then
            return v
        end
    end
    return nil
end

local function head(list)
    if predicates.isTable(list) == false then
        return nil, 'list is not a table'
    end
    return list[1]
end

local function last(list)
    if predicates.isTable(list) == false then
        return nil, 'list is not a table'
    end
    local len = length(list)
    return list[len]
end

local function tail(list)
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

local function initial(list)
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

local function difference2(list, values)
    if predicates.isTable(list) == false then
        return nil, 'list is not a table'
    end
    if predicates.isTable(values) == false then
        return nil, 'values is not a table'
    end

    local included = {}
    for i, v in ipairs(list) do
        local foundIndex = findIndex(0, function(item) return item == v end, values)
        if foundIndex == -1 then
            table.insert(included, v)
        end
    end
    return included
end

-- _.fill(Array(10), 'a')
local function fill(value, startIndex, endIndex, tbl)
    if predicates.isNil(value) == true then
        return nil, 'you cannot fill a Lua table with a bunch of nils as the last item to have nil is considered the end'
    end
    if predicates.isNumber(startIndex) == false then
        return nil, 'startIndex is not a number'
    end
    if predicates.isNumber(endIndex) == false then
        return nil, 'endIndex is not a number'
    end
    if predicates.isTable(tbl) == false then
        return nil, 'tbl is not a table'
    end

    for i=startIndex,endIndex,1 do
        tbl[i] = value
    end
    return tbl
end

-- TODO: it mutates, ugh...
local function insertABunch(list, items)
    for i, v in ipairs(items) do
        table.insert(list, v)
    end
    return list
end

local function flatten(list)
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

list.indexOf = func.curry(3, indexOf)
list.findIndex = func.curry(3, findIndex)
list.find = func.curry(3, find)
list.head = head
list.last = last
list.tail = tail
list.initial = initial
list.difference2 = func.curry(2, difference2)
list.fill = func.curry(4, fill)
list.flatten = flatten

return list
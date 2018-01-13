local list = {}

local predicates = require "./src/predicates"
local func = require "./src/func"

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

list.indexOf = func.curry(3, indexOf)
list.findIndex = func.curry(3, findIndex)
list.find = func.curry(3, find)

return list
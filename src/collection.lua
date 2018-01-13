local collection = {}

local func = require "./src/func"
local predicates = require "./src/predicates"

local function length(list)
    if predicates.isTable(list) == false then
        return 0, 'list is not a table'
    end
    local count = 0
    for _ in pairs(list) do count = count + 1 end
    return count
end

local function map(func, list)
    if predicates.isTable(list) == false then
        return {}, 'list is not a table'
    end
    if predicates.isFunction(func) == false then
        return {}, 'func is not a function'
    end
    local built = {}
    for i, v in ipairs(list) do
        table.insert(built, func(v))
    end
    return built
end

local function filter(func, list)
    if predicates.isTable(list) == false then
        return {}, 'list is not a table'
    end
    if predicates.isFunction(func) == false then
        return {}, 'func is not a function'
    end
    local built = {}
    for i, v in ipairs(list) do
        local include = func(v)
        if include == true then
            table.insert(built, v)
        end
    end
    return built
end

local function reduce(func, starting, list)
    if predicates.isTable(list) == false then
        return {}, 'list is not a table'
    end
    if predicates.isFunction(func) == false then
        return {}, 'func is not a function'
    end
    local currentResult = starting
    for i, v in ipairs(list) do
        currentResult = func(currentResult, v)
    end
    return currentResult
end

local function every(func, list)
    if predicates.isTable(list) == false then
        return false, 'list is not a table'
    end
    if predicates.isFunction(func) == false then
        return false, 'func is not a function'
    end
    for i, v in ipairs(list) do
        local result = func(v)
        if result == false then
            return false
        end
    end
    return true
end

local function some(func, list)
    if predicates.isTable(list) == false then
        return false, 'list is not a table'
    end
    if predicates.isFunction(func) == false then
        return false, 'func is not a function'
    end
    for i, v in ipairs(list) do
        local result = func(v)
        if result == true then
            return true
        end
    end
    return false
end


collection.length = length
collection.map = func.curry(2, map)
collection.filter = func.curry(2, filter)
collection.reduce = func.curry(3, reduce)
collection.every = func.curry(2, every)
collection.some = func.curry(2, some)



return collection
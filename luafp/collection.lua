--- Lua FP collections module. All functions that have more than 1 parameter are curried.
-- @module luafp.collection
-- @alias collection
local collection = {}

local func = require "luafp.func"
local predicates = require "luafp.predicates"

--- length of a list, counts how many items are in a table.
-- @param list a table with items in it
-- @return integer length of the table
-- @return string error message if parameter validation failed
-- @usage local collection = require 'luafp/collection'
-- cows = {'uno', 'dos', 'tres'}
-- print(collection.length(cows)) -- 3
function collection.length(list)
    if predicates.isTable(list) == false then
        return 0, 'list is not a table'
    end
    local count = 0
    for _ in pairs(list) do count = count + 1 end
    return count
end

--- takes a table in, runs the function on each item in the table, stores the results in a new table, and returns that table.
-- @param func function that takes the item from the table, and whatever you return goes into the new table.
-- @param list Table of items you wish to map to someting else.
-- @return list has your mapped items in it
-- @return string error message if parameter validation failed
-- @usage local collection = require 'luafp/collection'
-- ingredients = {'🐮', '🥔', '🐔', '🌽'}
-- function cook(item)
--     if item == '🐮' then
--         return '🍔'
--     else if item == '🥔' then
--         return '🍟'
--     else if item == '🐔' then
--         return '🍗'
--     else if item == '🌽' then
--         return '🍿'
--     end
-- end
-- results = collection.map(ifCowTurnToChicken, ingredients)
-- -- results would be:
-- {'🍔', '🍟', '🍗', '🍿'}
function collection.map(func, list)
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

--- takes a table in, runs the predicate on each item in the table to filter out only the items you want. For predicates that return true, the item will be included in a new list. If the predicate returns false, the item will not be included in the new list.
-- @param func predicate function that takes the item from the table, expected to return true, if you want to keep the item, or false if you don't.
-- @param list Table of items you wish to filter
-- @return list has your filtered items in it, if any
-- @return string error message if parameter validation failed
-- @usage local collection = require 'luafp/collection'
-- food = {'🍔', '🍟', '🍗', '🍿'}
-- function isVegetarian(item)
--     if item == '🍔' then
--         return false
--     else if item == '🍟' then
--         return true
--     else if item == '🍗' then
--         return false
--     else if item == '🍿' then
--         return true
--     end
-- end
-- results = collection.filter(isVegetarian, food)
-- -- results would be:
-- {'🍟', '🍿'}
function collection.filter(func, list)
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


--- takes a table in with an accumulator, runs the function on each item in the table, stores the results in the accumulator, and returns the final accumulator result.
-- @param func reducer function; takes your item and current accumulator value in, and whatever you return is the new accumulator value.
-- @param accumulator starting value for your reduce function
-- @param list Table of items you wish to reduce.
-- @return value Whatever the accumulator value is computed from your reducer.
-- @return string error message if parameter validation failed
-- @usage local collection = require 'luafp/collection'
-- food = {'🍔', '🍟', '🍗', '🍿'}
-- function eat(acc, item)
--     return '💩'
-- end
-- results = collection.reduce(eat, food)
-- -- results would be:
-- {'💩'}
function collection.reduce(func, accumulator, list)
    if predicates.isTable(list) == false then
        return {}, 'list is not a table'
    end
    if predicates.isFunction(func) == false then
        return {}, 'func is not a function'
    end
    local currentResult = accumulator
    for i, v in ipairs(list) do
        currentResult = func(currentResult, v)
    end
    return currentResult
end

--- Takes a table and runs a predicate function on each item. If all of them return true, then this function returns true, else false.
-- @param func predicate function that takes each item of the list and is expected to return true or false.
-- @param list Table of items you wish to verify.
-- @return value true or false
-- @return string error message if parameter validation failed
-- @usage local collection = require 'luafp/collection'
-- animals = {'🐮', '🐔', '🐷'}
-- function isAnimal(item)
--     if item == '🐷' or item == '🐔' or item == '🐷' then
--         return true
--     else
--         return false
--     end
-- end
-- allAnimals = collection.every(isAnimal, animals)
-- print(allAnimals) -- true
function collection.every(func, list)
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

--- Takes a table and runs a predicate function on each item. If at least one returns true, then this function returns true, else false.
-- @param func predicate function that takes each item of the list and is expected to return true or false.
-- @param list Table of items you wish to verify.
-- @return value true or false
-- @return string error message if parameter validation failed
-- @usage local collection = require 'luafp/collection'
-- items = {'🐮', '🐔', '🐷', '🌽'}
-- function isPlant(item)
--     if item == '🌽' then
--         return true
--     else
--         return false
--     end
-- end
-- hasAPlant = collection.some(isPlant, items)
-- print(hasAPlant) -- true
function collection.some(func, list)
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

collection.map = func.curry(collection.map)
collection.filter = func.curry(collection.filter)
collection.reduce = func.curry(collection.reduce)
collection.every = func.curry(collection.every)
collection.some = func.curry(collection.some)

return collection
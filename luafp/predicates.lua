--- Lua FP predicates module.
-- @module luafp.predicates
-- @alias predicates
local predicates = {}


--- Predicate function that returns if the object you pass in is nil or not.
-- @param o some object to check
-- @return yesOrNo true if it's nil, false if it's not
-- @usage local isNil = require 'luafp.predicates'.isNil
-- print(isNil(nil)) -- true
-- print(isNil('cow')) -- false
function predicates.isNil(o)
    return type(o) == 'nil'
end

--- Predicate function that returns if the object you pass in is a Boolean or not.
-- @param o some object to check
-- @return yesOrNo true if it's a Boolean, false if it's not
-- @usage local isBoolean = require 'luafp.predicates'.isBoolean
-- print(isBoolean(nil)) -- false
-- print(isBoolean()) -- false
-- print(isBoolean('cow')) -- false
-- print(isBoolean('')) -- false
-- print(isBoolean(true)) -- true
-- print(isBoolean(false)) -- true
function predicates.isBoolean(o)
    return type(o) == 'boolean'
end

--- Predicate function that returns if the object you pass in is a Number or not.
-- @param o some object to check
-- @return yesOrNo true if it's a Number, false if it's not
-- @usage local isNumber = require 'luafp.predicates'.isNumber
-- print(isNumber(1)) -- true
-- print(isNumber(1.23)) -- true
-- print(isNumber(1.0)) -- true
-- print(isNumber('1')) -- false
function predicates.isNumber(o)
    return type(o) == 'number'
end

--- Predicate function that returns if the object you pass in is a String or not.
-- @param o some object to check
-- @return yesOrNo true if it's a String, false if it's not
-- @usage local isString = require 'luafp.predicates'.isString
-- print(isString('sup')) -- true
-- print(isString('')) -- true
-- print(isString(1)) -- false
function predicates.isString(o)
    return type(o) == 'string'
end

--- Predicate function that returns if the object you pass in is a Userdata or not.
-- @param o some object to check
-- @return yesOrNo true if it's an Userdata, false if it's not
-- @usage local isUserdata = require 'luafp.predicates'.isUserdata
-- print(isUserdata(RobloxCharacter)) -- true
-- print(isUserdata({})) -- false
-- print(isUserdata(1)) -- false
function predicates.isUserdata(o)
    return type(o) == 'userdata'
end

--- Predicate function that returns if the object you pass in is a Function or not.
-- @param o some object to check
-- @return yesOrNo true if it's an Function, false if it's not
-- @usage local isFunction = require 'luafp.predicates'.isFunction
-- print(isFunction(function() return true end)) -- true
-- local cow = function() return true end
-- print(isFunction(cow)) -- true
-- local thing = {}
-- thing.sup = function() return true end
-- print(isFunction(thing.sup)) -- true
-- print(isFunction({})) -- false
function predicates.isFunction(o)
    return type(o) == 'function'
end

--- Predicate function that returns if the object you pass in is a Thread or not.
-- @param o some object to check
-- @return yesOrNo true if it's an Thread, false if it's not
-- @usage local isThread = require 'luafp.predicates'.isThread
-- function blade()
--     print("blood")
--     coroutine.yeild()
--     print("is")
--     coroutine.yeild()
--     print("pumpin'")
-- end
-- co = coroutine.create(blade)
-- print(isThread(blade)) -- false
-- print(isThread(co)) -- true
function predicates.isThread(o)
    return type(o) == 'thread'
end

--- Predicate function that returns if the object you pass in is a Table or not.
-- @param o some object to check
-- @return yesOrNo true if it's an Table, false if it's not
-- @usage local isTable = require 'luafp.predicates'.isTable
-- print(isTable(function() return true end)) -- false
-- print(isTable({})) -- true
function predicates.isTable(o)
    return type(o) == 'table'
end

--- Predicate function that returns if the object you pass in is not nil.
-- @param o some object to check
-- @return yesOrNo true if it's not nil, false if it's nil
-- @usage local exists = require 'luafp.predicates'.exists
-- print(exists(function() return true end)) -- true
-- print(exists({})) -- true
-- print(exists()) -- false
-- print(exists(nil)) -- false
function predicates.exists(o)
    return predicates.isNil(o) == false
end

--- Predicate function that returns true if the object you pass is a cow
-- @param o some object to check
-- @return yesOrNo true if it's a cow, false if it's not
-- @usage local exiisCowts = require 'luafp.predicates'.isCow
-- print(isCow('cow') -- true
-- print(isCow('🐮')) -- true
-- print(isCow('Jesse')) -- false
function isCow(o)
    return o == 'cow' or o == '🐮'
end

return predicates
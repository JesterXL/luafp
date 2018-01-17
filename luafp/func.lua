--- luafp functions module
-- @module luafp.func
-- @alias func
local func = {}

local function clone(t)
    local r = {}
    for i = 1, #t do
        r[#r + 1] = t[i]
    end
    return r
end

--- Takes your function arity (number of parameters) and a function, and turns it into a curried function. NOTE: We do not handle scope for you.
-- Reference: https://gist.githubusercontent.com/jcmoyer/5571987/raw/3064bc4df0f4c027843e62f3c6581c3ce3cf5217/currying.lua
-- @param f The function you wish to turn into a curried function.
-- @return curriedFunk Your curried function.
-- @usage local curry = require 'luafp/func'.curry
-- function add(a, b) return a + b end
-- addCurry = func.curry(add)
-- add1 = addCurry(1)
-- print(add1(2)) -- 3
function func.curry(f)
    local info = debug.getinfo(f, 'u')

    local function docurry(s, left, ...)
        local ptbl = clone(s)
        local vargs = {...}
        for i = 1, #vargs do
            ptbl[#ptbl + 1] = vargs[i]
        end
        left = left - #vargs
        if left > 0 then
            return function(...)
                return docurry(ptbl, left, ...)
            end
        else
            return f(table.unpack(ptbl))
        end
    end

    return function(...)
            return docurry({}, info.nparams, ...)
    end
end

--- Takes a predicate function and reverse the value returned. If the function returns true, it'll now return false. If the function returns false, it'll now return true.
-- @param func Your predicate function, a function that only returns true or false. Parameter count doesn't matter, we'll unpack and call it for you.
-- @return negated Your reversed predicate function.
-- @usage local func = require 'luafp/func'.negate
-- function isCow(o) return o == 'cow' end
-- print(isCow('cow')) -- true
-- isNotCowLulz = func.negate(isCow)
-- print(isNotCowLulz('cow')) -- false
-- print(isNotCowLulz('chicken')) -- true
function func.negate(func)
    local function wrapped(...)
        local args = {...}
        local result = func(table.unpack(args))
        if result == true then
            return false
        else
            return true
        end
    end
    return wrapped
end

return func
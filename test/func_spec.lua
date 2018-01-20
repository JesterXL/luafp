local func = require 'luafp.func'
local curry = func.curry

describe("src/func.lua", function()
    describe('negate', function()
        local isCow = function(o) return o == 'cow' end
        it('should reverse a predicate', function()
            local isNotCow = func.negate(isCow)
            assert.True(isNotCow('scumbag'))
        end)
        it('but the same predicate is the reverse', function()
            assert.False(isCow('scumbag'))
        end)
        it('should reverse a false', function()
            local isOk = function() return false end
            local isOkMan = func.negate(isOk)
            assert.True(isOkMan())
        end)
        it('should reverse a true', function()
            local isOk = function() return true end
            local isOkMan = func.negate(isOk)
            assert.False(isOkMan())
        end)
    end)
    describe('curry', function()
        it('should create a curried function', function()
            local add = function(a, b) return a + b end
            local curried = curry(add)
            -- local add1 = add(1)
            assert.is_true(type(curried) == 'function')
        end)
        it('should give you a partial with less than arity', function()
            local add = function(a, b) return a + b end
            local curried = curry(add)
            local add1 = curried(1)
            assert.is_true(type(add1) == 'function')
        end)
        it('should give you a partial with less than arity that works', function()
            local add = function(a, b) return a + b end
            local curried = curry(add)
            local add1 = curried(1)
            local result = add1(5)
            assert.are.equal(6, result)
        end)
        it('curried arity 2 should work with 2 function calls, 1 argument each', function()
            local add = function(a, b) return a + b end
            local curried = curry(add)
            local result = curried(5)(7)
            assert.are.equal(12, result) 
        end)
        it('curried arity 2 should work with 1 function call, 2 arguments', function()
            local add = function(a, b) return a + b end
            local curried = curry(add)
            local result = curried(5, 7)
            assert.are.equal(12, result) 
        end)
    end)
end)
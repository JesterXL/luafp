local func = require 'luafp.func'

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
    end)
end)
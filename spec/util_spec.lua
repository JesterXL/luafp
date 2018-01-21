local util = require 'luafp.util'
local identity = util.identity
local stubTrue = util.stubTrue
local stubFalse = util.stubFalse

describe("luafp/util.lua", function()
    describe('identity', function()
        it('should have party go in and a party come out', function()
            local party = 'party'
            local result = identity(party)
            assert.are.same(party, result)
        end)
    end)
    describe('stubTrue', function()
        it('should return true', function()
            assert.True(stubTrue())
        end)
        it('should return true despite being given cow', function()
            assert.True(stubTrue('cow'))
        end)
    end)
    describe('stubFalse', function()
        it('should return false', function()
            assert.False(stubFalse())
        end)
        it('should return false despite being given cow', function()
            assert.False(stubFalse('cow'))
        end)
    end)
end)
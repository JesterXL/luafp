local array = require 'luafp.array'

describe("src/array.lua", function()
    describe('difference2', function()
        it('should find missing cow', function()
            local diff = array.difference2({'uno', 'dos', 'tres'})({'tres'})
            assert.are.same({'uno', 'dos'}, diff)
        end)
        it('should find missing cow uncurried', function()
            local diff = array.difference2({'uno', 'dos', 'tres'}, {'tres'})
            assert.are.same({'uno', 'dos'}, diff)
        end)
    end)
    describe('fill', function()
        it('should fill a table with cow', function()
            local result = array.fill('cow')(1)(3)({})
            assert.are.same({'cow', 'cow', 'cow'}, result)
        end)
        it('should fill a table with cow even if filled with chicken', function()
            local MOORTTALLL_KOOMMMBATTT = {'chicken', 'Sub Zero'}
            local result = array.fill('cow')(3)(5)(MOORTTALLL_KOOMMMBATTT)
            assert.are.same({'chicken', 'Sub Zero', 'cow', 'cow', 'cow'}, result)
        end)
    end)
    describe('flatten', function()
        it('should flatten a basic list within list', function()
            local result = array.flatten({'a', 'b', {1, 2, 3}, 'c'})
            assert.are.same({'a', 'b', 1, 2, 3, 'c'}, result)
        end)
        it('should leave a basic list alone', function()
            local result = array.flatten({'a', 'b', 'c'})
            assert.are.same({'a', 'b', 'c'}, result)
        end)
        it('should leave a blank list alone', function()
            local result = array.flatten({})
            assert.are.same({}, result)
        end)
        it('should only go 1 level and not do insane recursion', function()
            local result = array.flatten({
                'a', 
                'b', 
                {
                    1, 
                    2, 
                    {'chicken', 'cow'}
                },
                3
            })
            assert.are.same({
                'a',
                'b',
                1,
                2,
                {'chicken', 'cow'},
                3
            }, result)
        end)
    end)
end)
local list = require './src/list'

describe("src/list.lua", function()
    describe('difference2', function()
        it('should find missing cow', function()
            local diff = list.difference2({'uno', 'dos', 'tres'})({'tres'})
            assert.are.same({'uno', 'dos'}, diff)
        end)
        -- TODO: right should work, check it out now, the funk soul bruvah
        -- it('should find missing cow on right #cow', function()
        --     local diff = list.difference2({'tres'})({'uno', 'dos', 'tres'})
        --     assert.are.same({'uno', 'dos'}, diff)
        -- end)
    end)
    describe('fill', function()
        it('should fill a table with cow', function()
            local result = list.fill('cow')(1)(3)({})
            assert.are.same({'cow', 'cow', 'cow'}, result)
        end)
        it('should fill a table with cow even if filled with chicken', function()
            local MOORTTALLL_KOOMMMBATTT = {'chicken', 'Sub Zero'}
            local result = list.fill('cow')(3)(5)(MOORTTALLL_KOOMMMBATTT)
            assert.are.same({'chicken', 'Sub Zero', 'cow', 'cow', 'cow'}, result)
        end)
    end)
    describe('flatten', function()
        it('should flatten a basic list within list', function()
            local result = list.flatten({'a', 'b', {1, 2, 3}, 'c'})
            assert.are.same({'a', 'b', 1, 2, 3, 'c'}, result)
        end)
        it('should leave a basic list alone', function()
            local result = list.flatten({'a', 'b', 'c'})
            assert.are.same({'a', 'b', 'c'}, result)
        end)
        it('should leave a blank list alone', function()
            local result = list.flatten({})
            assert.are.same({}, result)
        end)
        it('should only go 1 level and not do insane recursion', function()
            local result = list.flatten({
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
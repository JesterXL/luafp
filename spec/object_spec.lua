local object = require 'luafp.object'

describe("src/object.lua", function()
    describe('has', function()
        it('should give a property if there', function()
            local cow = { firstName = "Jesse" }
            assert.True(object.has('firstName')(cow))
        end)
        it('should give nil if not there', function()
            local cow = { firstName = "Jesse" }
            assert.False(object.has('badge')(cow))
        end)
        it('should give nil if nil value', function()
            assert.False(object.has('badge')('not there'))
        end)
        it('should give nil bogus path', function()
            assert.False(object.has('badge..cow', {}))
        end)
        it('works with nested paths', function()
            local account = {
                person = {
                    name = "Jesse",
                    address = {
                        city = "moogleville"
                    }
                }
            }
            local result = object.has('person.address.city')(account)
            assert.True(result)
        end)
        it('works with nested paths that have arrays in it', function()
            local account = {
                person = {
                    name = "Jesse",
                    address = {
                        city = "moogleville",
                        phone = {
                            '1234567890',
                            '8005551234'
                        }
                    }
                }
            }
            local result = object.has('person.address.phone[2]')(account)
            assert.True(result)
        end)
        it('works with nested paths that have arrays in it even deeper', function()
            local account = {
                person = {
                    name = "Jesse",
                    address = {
                        city = "moogleville",
                        phone = {
                            {
                                number = '1234567890',
                                type = 'home'
                            },
                            {
                                number = '8005551234',
                                type = 'cell'
                            }
                        }
                    }
                }
            }
            local result = object.has('person.address.phone[2].type')(account)
            assert.True(result)
        end)
        it('should fail with deeply nested object if blatant mispelling', function()
            local account = {
                person = {
                    name = "Jesse",
                    address = {
                        city = "moogleville",
                        phone = {
                            {
                                number = '1234567890',
                                type = 'home'
                            },
                            {
                                number = '8005551234',
                                type = 'cell'
                            }
                        }
                    }
                }
            }
            local result = object.has('person.address.phone[2].chicken')(account)
            assert.False(result)
        end)
        it('should fail with a bogus path', function()
            assert.False(object.has(123, {firstName="Jesse"}))
        end)
    end)
    describe('get', function()
        it('should give a property if there', function()
            local cow = { firstName = "Jesse" }
            assert.are.same(object.get('firstName')(cow), 'Jesse')
        end)
        it('should give nil if not there', function()
            local cow = { firstName = "Jesse" }
            assert.are.same(object.get('badge')(cow), nil)
        end)
        it('should give nil if nil value', function()
            assert.is_nil(object.get('badge')('not there'))
        end)
        it('should give nil if nil path', function()
            local cow = { firstName = "Jesse" }
            assert.is_nil(object.get(nil, cow))
        end)
        it('should give nil if dotted path is f00bared', function()
            local cow = { firstName = "Jesse" }
            assert.is_nil(object.get('some.cickehn..lesson', cow))
        end)
        it('should work with nested paths', function()
            local account = {
                person = {
                    name = "Jesse",
                    address = {
                        city = "moogleville"
                    }
                }
            }
            local result = object.get('person.address.city')(account)
            assert.are.same(result, 'moogleville')
        end)
        it('should work with nested paths that have arrays in it', function()
            local account = {
                person = {
                    name = "Jesse",
                    address = {
                        city = "moogleville",
                        phone = {
                            '1234567890',
                            '8005551234'
                        }
                    }
                }
            }
            local result = object.get('person.address.phone[2]')(account)
            assert.are.same(result, '8005551234')
        end)
        it('should work with nested paths that have arrays in it even deeper', function()
            local account = {
                person = {
                    name = "Jesse",
                    address = {
                        city = "moogleville",
                        phone = {
                            {
                                number = '1234567890',
                                type = 'home'
                            },
                            {
                                number = '8005551234',
                                type = 'cell'
                            }
                        }
                    }
                }
            }
            local result = object.get('person.address.phone[2].type')(account)
            assert.are.same(result, 'cell')
        end)
        it('should fail with deeply nested object if blatant mispelling', function()
            local account = {
                person = {
                    name = "Jesse",
                    address = {
                        city = "moogleville",
                        phone = {
                            {
                                number = '1234567890',
                                type = 'home'
                            },
                            {
                                number = '8005551234',
                                type = 'cell'
                            }
                        }
                    }
                }
            }
            local result = object.get('person.address.phone[2].chicken')(account)
            assert.is_nil(result)
        end)
    end)
    describe('getOr', function()
        it('should give a property if there', function()
            local cow = { firstName = "Jesse" }
            assert.are.same(object.getOr('chicken')('firstName')(cow), 'Jesse')
        end)
        it('should give default if not there', function()
            local cow = { firstName = "Jesse" }
            assert.are.same(object.getOr('chicken')('badge')(cow), 'chicken')
        end)
        it('should give default if nil value', function()
            assert.is_not_nil(object.getOr('chicken')('badge')(nil))
        end)
        it('should give default if nil path', function()
            local cow = { firstName = "Jesse" }
            assert.are.equal(object.getOr('wat', nil, cow), 'wat')
        end)
        it('should give nil if dotted path is f00bared', function()
            local cow = { firstName = "Jesse" }
            assert.are.equal(object.getOr('wat', 'some.cickehn..lesson', cow), 'wat')
        end)
        it('should work with nested paths', function()
            local account = {
                person = {
                    name = "Jesse",
                    address = {
                        city = "moogleville"
                    }
                }
            }
            local result = object.getOr('cheese')('person.address.city')(account)
            assert.are.same(result, 'moogleville')
        end)
        it('should work with nested paths that have arrays in it', function()
            local account = {
                person = {
                    name = "Jesse",
                    address = {
                        city = "moogleville",
                        phone = {
                            '1234567890',
                            '8005551234'
                        }
                    }
                }
            }
            local result = object.getOr('burger')('person.address.phone[2]')(account)
            assert.are.same(result, '8005551234')
        end)
        it('should work with nested paths that have arrays in it even deeper', function()
            local account = {
                person = {
                    name = "Jesse",
                    address = {
                        city = "moogleville",
                        phone = {
                            {
                                number = '1234567890',
                                type = 'home'
                            },
                            {
                                number = '8005551234',
                                type = 'cell'
                            }
                        }
                    }
                }
            }
            local result = object.getOr('sitar')('person.address.phone[2].type')(account)
            assert.are.same(result, 'cell')
        end)
        it('should fail with deeply nested object if blatant mispelling', function()
            local account = {
                person = {
                    name = "Jesse",
                    address = {
                        city = "moogleville",
                        phone = {
                            {
                                number = '1234567890',
                                type = 'home'
                            },
                            {
                                number = '8005551234',
                                type = 'cell'
                            }
                        }
                    }
                }
            }
            local result = object.getOr('vodka')('person.address.phone[2].chicken')(account)
            assert.are.same(result, 'vodka')
        end)
    end)
end)
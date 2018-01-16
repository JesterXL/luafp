-- local predicates = require('./src/predicates')
-- local func = require('./src/func')
-- local reactive = require "./src/reactive" 

function show(list)
    if type(list) ~= 'table' then
        return print('show failed, list is not a table')
    end
    -- local str
    -- for i, v in ipairs(list) do
    --     str
    -- end
    print(table.unpack(list))
    return
end

-- function mysplit(inputstr, sep)
--     if sep == nil then
--             sep = "%s"
--     end
--     local t={} ; i=1
--     for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
--             t[i] = str
--             i = i + 1
--     end
--     return t
-- end

-- show(mysplit('a.b.c', '.'))

-- local str = "a.[0].c"
-- local splitted = mysplit(str, '.')
-- print(splitted[2])
-- if string.find(splitted[2], "%[") then
--   print ("dem arrayz")
-- else
--   print ("nope")
-- end

-- function hasDots(path)
--     if predicates.isString(path) == false then
--         return false, 'path is not a string'
--     end
--     local startIndex = string.find(path, '%.')
--     return predicates.isNumber(startIndex)
-- end

-- TODO: make more verbose, perhaps splitting and checking
-- first and last character to be [ and ], including middle
-- to be a number. For now, just checking [.
-- function isArrayAccessor(path)
--     if predicates.isString(path) == false then
--         return false, 'path is not a string'
--     end
--     local startIndex = string.find(path, '%[')
--     return predicates.isNumber(startIndex)
-- end

-- print(hasDots('.'))
-- print(hasDots('some.cow.man'))
-- print(hasDots(' another cow eats'))
-- print(string.find('.', '%.'))
-- print(string.find('some.cow.man', '%.'))
-- print(string.find(' another cow eats', '%.'))
-- print(isArrayAccessor('[0]'))
-- print(isArrayAccessor('0'))
-- print(isArrayAccessor('someLargerPropName'))
-- print(isArrayAccessor('someLarger2PropName'))

-- local account = {
--     id = 'some id',
--     person = {
--         firstName = 'Jesse',
--         address = {
--             street = '123 cow st',
--             city = 'moogle town',
--             state = 'va'
--         },
--         numbers = {
--             '1234567890',
--             '8005551234'
--         }
--     }
-- }
-- local path = 'person.address.city'
-- local paths = mysplit(path, '.')
-- local holder = account
-- for i, v in ipairs(paths) do
--     holder = holder[v]
--     print(v)
-- end
-- print("holder:", holder)

-- local curry = require './src/func'.curry
-- local function add(a, b)
--     return a + b
-- end

-- -- print(add(1, 1))

-- local addCurry = curry(add) 
-- print(addCurry(20)(40))
-- print(addCurry(20, 40))
-- print("result:", result)
-- print(addCurry(1)(1))
-- print("-----")
-- print(addCurry(1, 1))

-- local arg = {}
-- local function dem(...)
--     local arg={...}
--     print(arg[1])
--     print("show:", show(arg))
-- end

-- dem(1, "a", {sup = 'man'})

-- local subject = reactive.getSubject()
-- local sub = subject:subscribe(
--     function(item) print("**next:", item) end,
--     function(error) print("**error:", error) end,
--     function(done) print("**done:", done) end
-- )
-- local sub2 = subject:subscribe(
--     function(item) print("^^next2:", item) end,
--     function(error) print("^^error2:", error) end,
--     function(done) print("^^done2:", done) end
-- )
-- subject:next("uno")
-- subject:next("dos")
-- sub:dispose()
-- subject:next("tres")
-- subject:error("t3h boom")
-- subject:complete("we done")
-- subject:next("how in the")

-- cow = {'uno', 'dos', 'tres'}
-- for i, v in ipairs(cow) do

--     if i >= 3 then
--         print("i:", i, "v:", v)
--     end
    
-- end

-- local difference2 = require "./src/list".difference2

-- local names = {'Jesse', 'Brandy', 'Cow'}
-- local wat = {'Cow'}
-- local result = difference2(names)(wat)
-- print("result")
-- show(result)
-- local result2 = difference2(wat)(names)
-- print("result2")
-- show(result2)

-- local fill = require './src/array'.fill

-- SpiceGirls = {}
-- show(fill('ziggyZigAh')(1)(3)(SpiceGirls))

-- local get = require './src/object'.get
-- turtle = {
--     firstName = 'Raphael', 
--     type = {
--         name = 'ninja',
--         weapons = {
--             {
--                 name = 'Sai',
--                 damage = 4
--             },
--             {
--                 name = 'Fist',
--                 damage = 2
--             }
--         }
--     }
-- }
-- print(get('type.weapons[1].damage')(turtle))


local isNil = require 'luafp.predicates'.isNil
print(isNil(nil)) -- true
print(isNil('cow')) -- false

-- local isBoolean = require './src/predicates'.isBoolean
-- print(isBoolean(nil)) -- false
-- print(isBoolean()) -- false
-- print(isBoolean('cow')) -- false
-- print(isBoolean('')) -- false
-- print(isBoolean(true)) -- true
-- print(isBoolean(false)) -- true

-- local isNumber = require './src/predicates'.isNumber
-- print(isNumber(1))
-- print(isNumber(1.23))
-- print(isNumber(1.0))
-- print(isNumber('1'))

-- local isString = require './src/predicates'.isString
-- print(isString('sup')) -- true
-- print(isString('')) -- true
-- print(isString(1)) -- false

-- local isFunction = require './src/predicates'.isFunction
-- print(isFunction(function() return true end))
-- local cow = function() return true end
-- print(isFunction(cow))
-- local thing = {}
-- thing.sup = function() return true end
-- print(isFunction(thing.sup))
-- print(isFunction({}))

-- local isThread = require './src/predicates'.isThread
-- function blade()
--     print("blood")
--     coroutine.yeild()
--     print("is")
--     coroutine.yeild()
--     print("pumpin'")
-- end
-- co = coroutine.create(blade)
-- print(isThread(blade))
-- print(isThread(co))

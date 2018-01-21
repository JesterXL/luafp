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


-- local isNil = require 'luafp.predicates'.isNil
-- print(isNil(nil)) -- true
-- print(isNil('cow')) -- false

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

-- local isEmptyString = require 'luafp.predicates'.isEmptyString
-- print(isEmptyString('')) -- true
-- print(isEmptyString("")) -- true
-- print(isEmptyString('cow')) -- false
-- print(isEmptyString(nil)) -- false
-- print(isEmptyString(5)) -- false


-- function _has(name, tbl)
-- 	return tbl[name] ~= nil
-- end
-- function has(name, tbl)
-- 	local result, err = pcall(_has, name, tbl)
-- 	print("result:", result)
-- 	print("err:", err)
-- 	return true
-- end

-- function unsafeHas(name, tbl)
--     return tbl[name] ~= nil
-- end

-- function has(name, tbl)
--     if name == nil then return false end
--     local ok, errorOrHas = pcall(unsafeHas, name, tbl)
--     if ok then
--         return errorOrHas 
--     else 
--         return false
--     end
-- end

-- function unsafeGet(name, tbl)
--     return tbl[name]
-- end

-- function get(name, tbl)
--     if name == nil then return nil end
--     local ok, errorOrValue = pcall(unsafeGet, name, tbl)
--     if ok then
--         return errorOrValue
--     else 
--         return nil
--     end
-- end

-- cow = {firstName = "Jesse"}
-- chicken = {}

-- print(has('firstName', cow))
-- print(has('firstName', chicken))
-- print(has('firstName', nil))
-- print(has(nil, cow))
-- print("   ")
-- print(get('firstName', cow))
-- print(get('firstName', chicken))
-- print(get('firstName', nil))
-- print(get(nil, cow))
-- print(" ")

-- local object = require 'luafp.object'
-- print(object.has('firstName', cow))
-- print(object.has('firstName', chicken))
-- print(object.has('firstName', nil))
-- print(object.has(nil, cow))
-- print("   ")
-- print(object.get('firstName', cow))
-- print(object.get('firstName', chicken))
-- print(object.get('firstName', nil))
-- print(object.get(nil, cow))


-- local curry = require 'luafp.func'.curry

-- function add(a, b)
--     print("add, a:", a, ", b:", b)
--     return a + b
-- end

-- curryAdd = curry(add)

-- -- print(add(1, 2))
-- print(curryAdd(1, 2))
-- print(curryAdd(1)(2))
-- print(curryAdd(1)(nil)(nil))

-- function add(a, b)
--         print("add, a:", a, ", b:", b)
--         return a + b
--     end

-- local fx = require('fx')
-- local f = fx.curry( 2, add )

-- print(f(1, 3))

-- local Maybe = require 'luafp.maybe'
-- local Just = Maybe.Just
-- local Nothing = Maybe.Nothing


-- local just1 = Just(1)
-- print(just1)
-- print(just1.value)
-- print(just1:getOrElse('cow'))
-- print(just1:matchWith({
--     Just = function(tbl) return tbl.value end,
--     Nothing = function() return 'nothing' end
-- }))
-- print(Just(1) == Just(1))
-- print(Just(1) == 1)
-- print(Just(1) == Nothing())
-- print("Just:hasInstance(just1):", Just:hasInstance(just1))

-- print(" ")
-- local nothing = Nothing()
-- print(nothing)
-- print(nothing.value)
-- print(nothing:getOrElse('cow'))
-- print(nothing:matchWith({
--     Just = function(tbl) return tbl.value end,
--     Nothing = function() return 'nothing' end
-- }))
-- print(Nothing() == Nothing())
-- print("Nothing:hasInstance(nothing):", Nothing:hasInstance(nothing))
-- print("Just:hasInstance(nothing):", Just:hasInstance(nothing))
-- print("Nothing:hasInstance(just1):", Nothing:hasInstance(just1))

-- print(" ")

-- function add1(o)
--     return o + 1
-- end

-- local just2 = Just(2)
-- print(just2)
-- print(just2:map(add1))
-- local nothing2 = Nothing()
-- print(nothing2)
-- print(nothing2:map(add1))

-- print(" ")

-- function breakIt()
--     return Nothing()
-- end

-- local just2 = Just(2)
-- print(just2)
-- -- print(just2:map(add1):map(breakIt))
-- print(just2:map(add1):chain(breakIt))

-- print(" ")

-- function addJust1(value)
--     return Just(value + 1)
-- end

-- function subtractJust5(value)
--     return Just(value - 5)
-- end

-- print(just2:chain(addJust1):chain(subtractJust5))

-- print(" ")
-- print(" ** orElse ** ")

-- function getError(o)
--     return Just('error')
-- end

-- print(Just(1):orElse(getError))
-- print(Nothing():orElse(getError))

local Result = require 'luafp.Result'
local Ok = Result.Ok
local Error = Result.Error
print(Ok(1) == Ok(2))
-- print(Result.Ok(1))
-- print(Result.Error('boom'))
-- print(Result.Ok({1, 2}))
-- print(Result.Ok({firstName="Jesse", lastName="Warden"}))

-- print(" ")
-- function add1(o)
--     return o + 1
-- end
-- print(Result.Ok(1):map(add1))
-- print(Result.Error('boom'):map(add1))

-- print(" ")
-- print(Ok(1):getOrElse('cow boom'))
-- print(Error('boom'):getOrElse('cow boom'))

-- print(" ")
-- function addBoom(o)
--     return o .. ' b00m!'
-- end
-- print(Ok(1):orElse('aw man'):mapError(addBoom))
-- print(Error('ka'):mapError(addBoom))

-- print(" ")
-- print(Ok(1):matchWith({
--     Error = function(tbl) return tbl.value end,
--     Ok = function(tbl) return tbl.value end
-- }))
-- print(Error('dat boom tho'):matchWith({
--     Error = function(tbl) return tbl.value end,
--     Ok = function(tbl) return tbl.value end
-- }))

-- print(" ")
-- function tryHardStuff1()
--     return Ok(1)
-- end
-- function tryHardStuff2(o)
--     return Ok(o + 1)
-- end
-- function tryHardStuff3(o)
--     return Error('boom done')
-- end
-- print(Ok(1):chain(tryHardStuff1):chain(tryHardStuff2))
-- print(Error('wat'):chain(tryHardStuff1):chain(tryHardStuff2))
-- print(Ok(1):chain(tryHardStuff1):chain(tryHardStuff2):chain(tryHardStuff3))

-- print(" ")
-- function itsOk()
--     return "we good"
-- end
-- function itsBoom()
--     return error('holy pow')
-- end
-- function itsYourBoom()
--     return error('holy pow', 2)
-- end
-- print(Result:try(itsOk))
-- print(Result:try(itsBoom))
-- print(Result:try(itsYourBoom))



-- local curry = require 'luafp.func'.curry
-- local function add(a, b)
--     return a + b
-- end

-- print(add(1, nil))


-- function getIt(f)
--     local info = debug.getinfo(f, 'u')
--     return function()
--         print(info.nparams)
--     end
-- end
-- function sup(man)
--     return true
-- end
-- local wat = getIt(sup)
-- wat()
local predicates = require('./src/predicates')
local func = require('./src/func')

function show(list)
    if predicates.isTable(list) == false then
        return
    end
    for i, v in ipairs(list) do
        print(v)
    end
    return
end

function mysplit(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            t[i] = str
            i = i + 1
    end
    return t
end

-- show(mysplit('a.b.c', '.'))

-- local str = "a.[0].c"
-- local splitted = mysplit(str, '.')
-- print(splitted[2])
-- if string.find(splitted[2], "%[") then
--   print ("dem arrayz")
-- else
--   print ("nope")
-- end

function hasDots(path)
    if predicates.isString(path) == false then
        return false, 'path is not a string'
    end
    local startIndex = string.find(path, '%.')
    return predicates.isNumber(startIndex)
end

-- TODO: make more verbose, perhaps splitting and checking
-- first and last character to be [ and ], including middle
-- to be a number. For now, just checking [.
function isArrayAccessor(path)
    if predicates.isString(path) == false then
        return false, 'path is not a string'
    end
    local startIndex = string.find(path, '%[')
    return predicates.isNumber(startIndex)
end

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

local function add(a, b)
    return a + b
end

-- print(add(1, 1))

local addCurry = func.curry(2, add) 
print(addCurry(1)(1))
-- print("-----")
-- print(addCurry(1, 1))

-- local arg = {}
-- local function dem(...)
--     local arg={...}
--     print(arg[1])
--     print("show:", show(arg))
-- end

-- dem(1, "a", {sup = 'man'})
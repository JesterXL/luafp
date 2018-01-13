local util = {}

local function identity(o)
    return o
end

local function stubTrue()
    return true
end

local function stubFalse()
    return false
end

util.identity = identity
util.stubTrue = stubTrue
util.stubFalse = stubFalse

return util
--- Lua FP util module.
-- @module luaFP.util
-- @alias util
local util = {}

--- Function that returns the first value it receives.
-- @param o value to return
-- @return value the value you sent
-- @usage local identity = require 'luaFP'.util.identity
-- local result = someFailedAction()
-- .matchWith({
--     Error = identity,
--     Ok = function() return Result.Ok(true) end
-- })
-- print(result) -- Result.Error('original error here')
function util.identity(o)
    return o
end

--- Function that always returns true
-- @return value true
-- @usage local stubTrue = require 'luaFP'.util.stubTrue
-- local stubFalse = require 'luaFP'.util.stubFalse
-- local didItWork = someSuccessfulAction()
-- .matchWith({
--     Error = stubFalse,
--     Ok = stubTrue
-- })
-- print(didItWork) -- true
function util.stubTrue()
    return true
end

--- Function that always returns true
-- @return value true
-- @usage local stubTrue = require 'luaFP'.util.stubTrue
-- local stubFalse = require 'luaFP'.util.stubFalse
-- local didItWork = someFailedAction()
-- .matchWith({
--     Error = stubFalse,
--     Ok = stubTrue
-- })
-- print(didItWork) -- false
function util.stubFalse()
    return false
end

return util
local object = {}

local predicates = require './src/predicates'

local function get(property, o)
    if predicates.isString(property) == false then
        return nil, 'property is not a string, so nothing to get'
    return
    if predicates.isNil(o) == true then
        return nil, 'o is nil, so nothing to get'
    end
end

return object
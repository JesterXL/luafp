local predicates = {}

function predicates.isNil(o)
    return type(o) == 'nil'
end

function predicates.isBoolean(o)
    return type(o) == 'boolean'
end

function predicates.isNumber(o)
    return type(o) == 'number'
end

function predicates.isString(o)
    return type(o) == 'string'
end

function predicates.isUserdata(o)
    return type(o) == 'userdata'
end

function predicates.isFunction(o)
    return type(o) == 'function'
end

function predicates.isThread(o)
    return type(o) == 'thread'
end

function predicates.isTable(o)
    return type(o) == 'table'
end

function predicates.exists(o)
    return predicates.isNil(o) == false
end

return predicates
--- luafp Maybe module. For now see: http://folktale.origamitower.com/api/v2.0.0/en/folktale.maybe.html
-- @module luafp.Maybe
-- @alias Maybe

local Just = {}
setmetatable(Just, {
    __call = function(t, value)
        t.value = value
        return t
    end,
    __tostring = function(t)
        return "Maybe::Just( " .. t.value .. " )"
    end,
    __eq = function(just1, just2)
        return just1.value == just2.value
    end
})
function Just:getOrElse(defaultValue)
    return self.value
end
function Just:matchWith(tbl)
    return tbl['Just'](self)
end
function Just:hasInstance(o)
    if type(o) ~= 'nil' then
        return o == Just(o.value)
    else
        return false
    end
end
function Just:map(f)
    return Just(f(self.value))
end
function Just:chain(f)
    return f(self.value)
end
function Just:orElse(f)
    return self
end




local Nothing = {}
setmetatable(Nothing, {
    __call = function(t, value)
        t.__nothing = true
        return t
    end,
    __tostring = function(t)
        return "Maybe::Nothing()"
    end,
    __eq = function(nothing1, nothing2)
        return nothing1.__nothing == true and nothing2.__nothing == true
    end
})
function Nothing:getOrElse(defaultValue)
    return defaultValue
end
function Nothing:matchWith(tbl)
    return tbl['Nothing']()
end
function Nothing:hasInstance(o)
    if type(o) ~= 'nil' then
        return Nothing() == o
    else
        return false
    end
end
function Nothing:map(f)
    return Nothing()
end
function Nothing:chain(f)
    return Nothing()
end
function Nothing:orElse(f)
    return f(self)
end


local Maybe = {}

function Maybe:empty()
    return Nothing()
end

function Maybe:of(o)
    return Just(o)
end

function Maybe:fromNullable(o)
    if type(o) == 'nil' then
        return Nothing()
    else
        return Just(o)
    end
end

Maybe.Just = Just
Maybe.Nothing = Nothing

return Maybe
--- luafp Result module. For now see: http://folktale.origamitower.com/api/v2.0.0/en/folktale.result.html
-- @module luafp.Result
-- @alias Result

local Ok = {}
setmetatable(Ok, {
    __call = function(t, value)
        t.__ok = true
        t.value = value
        return t
    end,
    __tostring = function(t)
        if type(t.value) == 'nil' then
            return "Result::Ok( nil )"
        elseif type(t.value) == 'table' then
            -- for key,value in pairs(t) do print(key,value) end
            local str = "{ "
            for i, v in pairs(t.value) do
                str = str .. i .. ":" .. tostring(v) .. ", "
            end
            str = str:sub(0, str:len() - 2)
            str = str .. " }"
            return "Result::Ok( " .. str .. " )"
        else
            return "Result::Ok( " .. t.value .. " )"
        end
    end,
    __eq = function(result1, result2)
        return result1.__ok == true and result2.__ok == true and result1.value == result2.value
    end
})
function Ok:getOrElse(defaultValue)
    return self.value
end
function Ok:matchWith(tbl)
    return tbl['Ok'](self)
end
function Ok:hasInstance(o)
    if type(o) ~= 'nil' then
        return o == Ok(o.value)
    else
        return false
    end
end
function Ok:map(f)
    return Ok(f(self.value))
end
function Ok:mapError(f)
    return self
end
function Ok:chain(f)
    return f(self.value)
end
function Ok:orElse(f)
    return self
end
function Ok:merge()
    return self.value
end




local Error = {}
setmetatable(Error, {
    __call = function(t, value)
        t.__error = true
        t.value = value
        return t
    end,
    __tostring = function(t)
        if type(t.value) == 'nil' then
            return "Result::Error( nil )"
        else
            return "Result::Error( " .. t.value .. " )"
        end
    end,
    __eq = function(error1, error2)
        return error1.__error == true and error2.__error == true and error1.value == error2.value
    end
})
function Error:getOrElse(defaultValue)
    return defaultValue
end
function Error:matchWith(tbl)
    return tbl['Error'](self)
end
function Error:hasInstance(o)
    if type(o) ~= 'nil' then
        return Error() == o
    else
        return false
    end
end
function Error:map(f)
    return self
end
function Error:mapError(f)
    return Error(f(self.value))
end
function Error:chain(f)
    return self
end
function Error:orElse(f)
    return f(self)
end
function Error:merge()
    return self.value
end


local Result = {}

function Result:of(o)
    return Ok(o)
end

function Result:fromNullable(o)
    if type(o) == 'nil' then
        return Error(o)
    else
        return Ok(o)
    end
end

function Result:try(f)
    local results = {pcall(f)}
    if results[1] == true then
        table.remove(results)
        return Ok(results)
    else
        return Error(results[2])
    end
end

Result.Ok = Ok
Result.Error = Error

return Result
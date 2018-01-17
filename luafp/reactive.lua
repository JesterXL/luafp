-- game.Players.PlayerAdded:connect(function(player)
-- 	player.CharacterAdded:connect(function(character)
-- 		character.Humanoid.WalkSpeed = 25
-- 	end)
-- end)

--- Lua FP reactive module. Work in progress...
-- @module luafp.reactive
-- @alias reactive
local reactive = {}
local array = require "luafp.array"

local random = math.random

local function uuid()
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end

local function getSubscription(disposeCallback)
    local subscription = {}
    function subscription:dispose()
        disposeCallback()
    end
    return subscription
end

local function getSubject()
    local subject = {}
    subject.listeners = {}

    function subject:next(object)
        for i, v in ipairs(subject.listeners) do
            v.next(object)
        end
        return object
    end

    function subject:error(errorObject)
        for i, v in ipairs(subject.listeners) do
            v.error(errorObject)
        end
        return errorObject
    end

    function subject:complete(object)
        local cloned = {table.unpack(subject.listeners)}
        for i, v in ipairs(cloned) do
            v.removeIt(v.id)
            v.complete(object)
        end
        return object
    end

    function subject:subscribe(next, error, complete)
        local id = uuid()
        local removeIt = function()
            local index = array.findIndex(0)(function(item) return item.id == id end)(subject.listeners)
            table.remove(subject.listeners, index)
        end
        table.insert(subject.listeners, {
            id = id,
            next = next,
            error = error,
            complete = complete,
            removeIt = removeIt
        })
        return getSubscription(removeIt)
    end
    return subject
end

reactive.getSubject = getSubject

return reactive
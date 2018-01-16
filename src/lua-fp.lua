--- Lua FP module.
-- @module luaFP
-- @alias luaFP
local luaFP = {}

local collection = require "./src/collection"
local func = require "./src/func"
local list = require "./src/list"
local object = require "./src/object"
local predicates = require "./src/predicates"
local reactive = require "./src/reactive"
local util = require "./src/util"

luaFP.collection = collection
luaFP.func = func
luaFP.list = list
luaFP.object = object
luaFP.predicates = predicates
luaFP.util = util

return luaFP
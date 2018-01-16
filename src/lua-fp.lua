--- Lua FP module.
-- @module luaFP
-- @alias luaFP
local luaFP = {}

local collection = require "./src/collection"
local func = require "./src/func"
local array = require "./src/array"
local object = require "./src/object"
local predicates = require "./src/predicates"
local reactive = require "./src/reactive"
local util = require "./src/util"

luaFP.collection = collection
luaFP.func = func
luaFP.array = array
luaFP.object = object
luaFP.predicates = predicates
luaFP.util = util

return luaFP
local modules = (...) and (...):gsub('%.init$', '') .. ".luafp." or ""

local luafp = {
}

local files = {
    "array",
    "collection",
    "func",
    "Maybe",
    "object",
    "predicates",
    "reactive",
    "Result",
    "util"
}

for _, file in ipairs(files) do
	luafp[file] = require(modules .. file)
end

return luafp
local list = require "./src/list"
local predicates = require "./src/predicates"
local collection = require "./src/collection"

function show(list)
    if predicates.isTable(list) == false then
        return
    end
    for i, v in ipairs(list) do
        print(v)
    end
    return
end


-- show(list.map(function(i) return i + 1 end)({1, 2, 3}))
-- show(list.filter({"cow", "cheese", 4}, predicates.isString))
-- function sumThem(acc, item)
--     return acc + item
-- end
-- print(list.reduce({1, 2, 3}, sumThem, 0))

-- print(list.indexOf(0, 'cow', {'uno', 'dos', 'cow'}))
-- print(list.indexOf(0, 'chicken', {'uno', 'dos', 'cow'}))

-- local isCow = function(o) return o == 'cow' end
-- print(list.findIndex(0)(isCow)({'uno', 'dos', 'cow'}))
-- print(list.indexOf(0)(isCow)({'uno', 'dos', 'chicken'}))
-- local beginCow = list.findIndex(0)(isCow)
-- print(beginCow({'uno', 'dos', 'cow'}))
-- print(beginCow({'uno', 'dos', 'chicken'}))

-- local isCow = function(o) return o == 'cow' end
-- print(list.find(0)(isCow)({'uno', 'dos', 'cow'}))
-- print(list.find(0)(isCow)({'uno', 'dos', 'dat chicken tho'}))

-- local isCow = function(o) return o == 'cow' end
-- print(collection.every(isCow)({'cow', 'cow', 'cow'}))
-- print(collection.every(isCow)({'cow', 'chicken', 'cow'}))

-- local isCow = function(o) return o == 'cow' end
-- print(collection.some(isCow)({'cow', 'cow', 'cow'}))
-- print(collection.some(isCow)({'cow', 'chicken', 'cow'}))
-- print(collection.some(isCow)({'a', 'chicken', 'how now brown cow'}))
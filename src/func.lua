local func = {}

 -- reverse(...) : take some tuple and return a tuple of elements in reverse order
 --                  
 -- e.g. "reverse(1,2,3)" returns 3,2,1
local function reverse(...)
 
    --reverse args by building a function to do it, similar to the unpack() example
    local function reverse_h(acc, v, ...)
       if 0 == select('#', ...) then
      return v, acc()
       else
          return reverse_h(function () return v, acc() end, ...)
       end
    end  
 
    -- initial acc is the end of the list
    return reverse_h(function () return end, ...)
 end

 -- lol, DRY
local function length(list)
    if list == nil then
        return 0
    end
    local count = 0
    for _ in pairs(list) do count = count + 1 end
    return count
end

local function curry(num_args, func)

    -- currying 2-argument functions seems to be the most popular application
    num_args = num_args or 2
 
    -- no sense currying for 1 arg or less
    if num_args <= 1 then return func end

    -- helper takes an argtrace function, and number of arguments remaining to be applied
    local function curry_h(argtrace, n)
       if 0 == n then
      -- kick off argtrace, reverse argument list, and call the original function
          return func(reverse(argtrace()))
       else
          -- "push" argument (by building a wrapper function) and decrement n
          return function (onearg)
                    return curry_h(function () return onearg, argtrace() end, n - 1)
                 end
       end
    end  
    
    -- push the terminal case of argtrace into the function first
    return curry_h(function () return end, num_args)
 end
 
func.reverse = reverse
func.curry = curry

return func
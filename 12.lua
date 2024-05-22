local function addTable(x, y)
    return x.num + y.num
end

local metatable = {
    __call = function ()
        print("Calllllled")
    end,
    __add = addTable,
    __sub = function (x, y)
        return x.num - y.num
    end
}

local t1 = {num = 6}
local t2 = {num = 5}

setmetatable(t1, metatable)

local ans1 = t1 - t2
local ans2 = addTable(t1, t2)

print(ans1)
print(ans2)
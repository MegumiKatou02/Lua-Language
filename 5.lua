local arr = {1, 2, 3, 4, 2, 0}
print(table.concat(arr, " "))

local function Sum(a)
    a = a or 3
    print(string.format("Day la %i", a))
    if a == 3 then
        return "con cho"
    else
        return "con meo"
    end
end

print(Sum(4))

local function ChuoiTong(number)
    if number == 0 then
        return 0
    else 
        return number + ChuoiTong(number - 1)
    end
end

print(ChuoiTong(4))

local function test()
    local count = 0
    return function ()
        count = count + 1
        return count
    end
end

local x = test()

local function HELLO(...)
    local sum = 0
    for key, value in pairs({...}) do
        print(key, value)
        sum = sum + value
    end
    return sum
end

local real = HELLO(3,4,5,1,2,6)
print(type(real) .. ":", real)
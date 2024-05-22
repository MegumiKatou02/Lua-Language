local function t1(number)
    return number * 10
end

local t2 = function (number)
    return number * 20
end

local t3 = t1

-- print(t1(3))
-- print(t2(3))

local final1 = coroutine.create(
    function ()
        for i = 1, 10, 1 do
            print("Routine 1: " .. i)
            if i == 5 then
                print()
                coroutine.yield()
            end
        end
        print()
    end
)

local fi2 = function ()
    for i = 11, 20, 1 do
        print("Routine 2: " .. i)
    end
    print()
end

local final2 = coroutine.create(fi2)

coroutine.resume(final1)
coroutine.resume(final1)
print(coroutine.status(final1))
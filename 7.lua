local co1

co1 = coroutine.create(function()
    print("Coroutine co1 starts")
    local co2 = coroutine.create(function()
        print("Inside coroutine co2")
        print("Status of co1: " .. coroutine.status(co1))  -- Output: normal
    end)
    coroutine.resume(co2)
    print("Coroutine co1 resumes")
end)

coroutine.resume(co1)
print(coroutine.status(co1))

local co1 = coroutine.create(function (a)
    print("Thread: " .. a)
    for i = 1, 5, 1 do
        print("co1", i)
        coroutine.yield();
    end
end)

local co2 = coroutine.create(function ()
    for i = 1, 5, 1 do
        print("co2", i)
        print(coroutine.status(co1))
        coroutine.yield();
    end
    print()
end)

for i = 1, 10, 1 do
    print(i)
    coroutine.resume(co1, 3)
end
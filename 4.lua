local str = "chinh la toi"
print(#str)

local newStr = #str
print(newStr)

local haha = "haah"
local full = #(str .. " " .. haha)
print(full)
print(str .. "\v" .. haha)

print(string.upper(str))
print(string.rep("Hello?", 5, "\n"))
local past = os.time({
    year = 2024,
    month = 5,
    day = 22,
    hour = 11,
    min = 20,
    sec = 10
})

print(os.time() - past)
print(os.difftime(os.time(), past))
print(os.date())
-- os.execute("cls")
local start = os.clock()
print(start * 3600 * 60)
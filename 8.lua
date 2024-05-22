-- Mở tập tin văn bản để đọc
local file = io.open("myFile.txt", "w")

-- Đọc và in các số từ tập tin
if file then
    file:write("hello chinh")
    file:write("\nhaha\n")
    file:close()
else print("null")
end
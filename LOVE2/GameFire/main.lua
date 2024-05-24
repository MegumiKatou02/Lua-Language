---@diagnostic disable: lowercase-global
local love = require("love")

fonts = {
    medium = love.graphics.newFont(24)
}

function ChangeSkinPlayer(leftMove)
    if leftMove == true then
        return love.graphics.newImage("image/Walk1.png")
    end
    return love.graphics.newImage("image/Walk2.png")
end

player = {
    x = 400, -- Vị trí giữa màn hình
    y = 300,
    angle = 0
}

camera = {
    x = 0,
    y = 0
}

function PlayerMove()
    if love.keyboard.isDown("d") then
        player.x = player.x + player.vec
    end
    if love.keyboard.isDown("a") then
        player.x = player.x - player.vec
    end
    if love.keyboard.isDown("w") then
        player.y = player.y - player.vec
    end
    if love.keyboard.isDown("s") then
        player.y = player.y + player.vec
    end
end

function love.load()
    num = 0
    player.x, player.y = 200, 200
    player.vec = 3.5
    player.skin = love.graphics.newImage("image/idle.png")
    background = love.graphics.newImage("image/tt.jpg")
end

function love.update(dt)

    local mouseX, mouseY = love.mouse.getPosition()

    player.angle = math.atan(mouseY - player.y, mouseX - player.x)

    num = num + 1
    PlayerMove()
    camera.x = player.x - love.graphics.getWidth() / 2
    camera.y = player.y - love.graphics.getHeight() / 2
end

function love.draw()
    love.graphics.push() -- Lưu trạng thái hiện tại của hệ tọa độ
    
    love.graphics.translate(-camera.x, -camera.y) -- Dịch chuyển hệ tọa độ
    
    love.graphics.draw(background, 0, 0) -- Vẽ hình nền
    
    -- love.graphics.draw(player.skin, player.x, player.y, 0, 0.3, 0.3) -- Vẽ người chơi
    
    love.graphics.draw(
        player.skin, player.x, player.y, player.angle,
        0.3, 0.3, -- Scale theo trục x và y
        player.skin:getWidth() / 2, player.skin:getHeight() / 2 -- Điểm gốc để xoay
    )

    love.graphics.print(camera.x .. "\t" .. camera.y, 100, 100)
    love.graphics.print(background:getWidth() .. "\t" .. background:getHeight(), 100, 150)
    love.graphics.print(player.skin:getWidth() * 0.3 .. "\t" .. player.skin:getHeight() * 0.3, 0, 200)
    love.graphics.pop()
    love.graphics.print(player.x .. "\t" .. player.y, 0, 150)

end
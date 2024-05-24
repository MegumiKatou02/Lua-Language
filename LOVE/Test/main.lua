---@diagnostic disable: lowercase-global
local love = require "love"
local testP = require "Player"

player = {}
game = {}

camera = {
    x = 0,
    y = 0
}

function KhoangCach(x1, y1, x2, y2)
    return math.sqrt((x1 - x2)^2 + (y1 - y2)^2)
end

function TinhGoc()
    local Hx = player.x
    local Hy = player.y
    local mouseX, mouseY = love.mouse.getPosition()
    local angle = math.atan(mouseY - Hy, mouseX - Hx)
    player.angle = angle
end

function love.load()
    p = testP()
    player.x, player.y = 300, 300
    game.standardX, game.standardY = 300, 300
    player.vec = 3;
    player.angle = 0 -- [0 -> 2pi]
    player.skin = love.graphics.newImage("player.png");
    game.background = love.graphics.newImage("background.png");
end

function PlayerMove()
    -- if love.keyboard.isDown("d") then
    --     player.x = player.x + player.vec
    -- end
    -- if love.keyboard.isDown("a") then
    --     player.x = player.x - player.vec
    -- end
    -- if love.keyboard.isDown("w") then
    --     player.y = player.y - player.vec
    -- end
    -- if love.keyboard.isDown("s") then
    --     player.y = player.y + player.vec
    -- end
end

function love.update(dt)
    PlayerMove()
    p:movePlayer(dt)
    -- TinhGoc()
    camera.x = player.x - love.graphics.getWidth() / 2
    camera.y = player.y - love.graphics.getHeight() / 2
end

function love.draw()
    -- love.graphics.push() --
    
    -- love.graphics.translate(-camera.x, -camera.y) -- 
    -- love.graphics.draw(game.background, 0, 0);
    -- love.graphics.draw(player.skin, player.x, player.y, player.angle, 1, 1,
    --     player.skin:getWidth()/2,
    --     player.skin:getHeight()/2
    -- )
    p:draw()
    -- love.graphics.pop()
end
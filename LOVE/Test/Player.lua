---@diagnostic disable: undefined-global
local love = require "love"

function Player()
    local VIEW_ANGLE = math.rad(90)
    local SIZE = 30
    local skin = love.graphics.newImage("player.png")
    return {
        x = love.graphics.getWidth() / 2,
        y = love.graphics.getHeight() / 2,
        radius = SIZE / 2,
        angle = 0,
        rotationSpeed = math.rad(90),

        draw = function (self)
            -- love.graphics.polygon(
            --     "line",
            --     self.x + ((4 / 3) * self.radius) * math.cos(self.angle),
            --     self.y -  ((4 / 3) * self.radius) * math.sin(self.angle),
            --     self.x - self.radius * (2 / 3 * math.cos(self.angle) + math.sin(self.angle)),
            --     self.y + self.radius * (2 / 3 * math.sin(self.angle) - math.cos(self.angle)),
            --     self.x - self.radius * (2 / 3 * math.cos(self.angle) - math.sin(self.angle)),
            --     self.y + self.radius * (2 / 3 * math.sin(self.angle) + math.cos(self.angle))
            -- )
            love.graphics.draw(skin, 200, 200, angle, 1, 1, player.skin:getWidth() / 2, player.skin:getHeight() / 2)
        end,

        movePlayer = function (self, dt)
            if love.keyboard.isDown("a") then
                player.angle = player.angle - player.rotationSpeed * dt
            end
            if love.keyboard.isDown("d") then
                player.angle = player.angle + player.rotationSpeed * dt
            end
        end
    }
end

return Player
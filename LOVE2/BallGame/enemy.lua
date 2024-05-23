local love = require("love")

function Enemy(level)
    local dice = math.random(1, 4)
    local _x, _y
    local _radius = 20

    if dice == 1 then
        _x = math.random(_radius, love.graphics.getWidth())
        _y = - _radius * 4
    elseif dice == 2 then
        _x = - _radius * 4
        _y = math.random(_radius, love.graphics.getHeight())
    elseif dice == 3 then
        _x = math.random(_radius, love.graphics.getWidth())
        _y = _radius * 4 + love.graphics.getHeight()
    else
        _x = _radius * 4 + love.graphics.getWidth()
        _y = math.random(_radius, love.graphics.getHeight())
    end

    return {
        level = level or 1.5,
        radius = _radius,
        x = _x,
        y = _y,

        move = function (self, player_x, player_y)
            if player_x > self.x then
                self.x = self.x + self.level
            elseif player_x < self.x then
                self.x = self.x - self.level
            end

            if player_y > self.y then
                self.y = self.y + self.level
            elseif player_y < self.y then
                self.y = self.y - self.level
            end
        end,

        draw = function (self)
            math.randomseed(os.time())
            local x, y, z = math.random(0, 1), math.random(0, 1), math.random(0, 1)
            if x == 0 and y == 0 and z == 0 then
                x, y, z = 0, 1, 0
            end
            love.graphics.setColor(x, y, z)

            love.graphics.circle("fill", self.x, self.y, self.radius)
            love.graphics.setColor(1, 1, 1)
        end
    }
end

return Enemy
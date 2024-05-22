_G.love = require("love")

function love.load()
    _G.number = 0
    _G.Box = {}
    Box.x = 100
    Box.y = 100
    Box.xmove = 2
    Box.eat = false

    _G.Food_x = 600
end

function love.update(dt)
    Box.x = Box.x + Box.xmove

    if Box.x >= Food_x + 20 then
        Box.eat = true
    end
end

function love.draw()
    if not Box.eat then
        love.graphics.setColor(0, 1, 0)
        love.graphics.circle("fill", 300, 300, 70)
    end
    love.graphics.setBackgroundColor(126 / 255, 66 / 255, 245/ 255)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Hello Chinh " .. number)
    love.graphics.setColor(200 / 255, 245 / 255, 66 / 255)
    love.graphics.rectangle("fill", Box.x, Box.y, 50, 50)
end
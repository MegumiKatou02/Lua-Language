local love = require("love")
local enemy = require("enemy")
local button = require("Button")

math.randomseed(os.time())

local game = {
    difficulty = 1,
    state = {
        menu = true,
        pause = false,
        running = false,
        ended = false
    }
}

local player = {
    radius = 20,
    x = 30,
    y = 30,
    score = 0
}

local delta = 0
local standardScore = 5

local buttons = {
    menu_state = {}
}

local enemies = {}

local function StartNewGame()
    game.state["menu"] = false
    game.state["running"] = true

    table.insert(enemies, 1, enemy())
end

function love.mousepressed(x, y, button, istouch, presses)
    if not game.state["running"] then
        if button == 1 then
            if game.state["menu"] then
                for index in pairs(buttons.menu_state) do
                    buttons.menu_state[index]:checkPressed(x, y,  player.radius)
                end
            end
        end
    end
end

local function distance(x1, y1, x2, y2)
    return math.sqrt((x1 - x2)^2 + (y1 - y2)^2)
end

local function gameover()
    if game.state["running"] then
        for i = 1, #enemies do
            local x1, y1 = enemies[i].x, enemies[i].y
            local x2, y2 = love.mouse.getPosition()
            if distance(x1, y1, x2, y2) <= enemies[i].radius + player.radius then
                os.exit()
            end
        end
    end
end

function love.load()
    love.window.setTitle("Ching's ball")
    love.mouse.setVisible(false)

    buttons.menu_state.play_game = button("Player Game", StartNewGame, nil, 120, 40)
    buttons.menu_state.settings = button("Settings", nil, nil, 120, 40)
    buttons.menu_state.exit_game = button("Exit Game", love.event.quit, nil, 120, 40)
end

function love.update(dt)
    gameover()
    player.x, player.y = love.mouse.getPosition()

    if game.state["running"] then
        for i = 1, #enemies do
            enemies[i]:move(player.x, player.y)
        end
    end

    delta = delta + 1
    if(delta >= 100) then
        player.score = player.score + 1
        if player.score == standardScore then
            table.insert(enemies, #enemies + 1, enemy())
            standardScore = standardScore + 15
            for i = 1, #enemies do
                enemies[i].level = enemies[i].level + 0.5
            end
        end
        delta = 0
    end
end

function love.draw()
    -- print the score
    love.graphics.printf(
        "Score: " .. player.score, 
        love.graphics.newFont(16),
        love.graphics.getWidth() / 2 - 10, 
        10,
        love.graphics.getWidth()
    )
    --
    love.graphics.printf(
        "FPS: " .. love.timer.getFPS(), 
        love.graphics.newFont(16), 
        10, 
        love.graphics.getHeight() - 30,
        love.graphics.getWidth()
    )
    -- print the enemies's number
    love.graphics.printf(
        "Enemies: " .. #enemies,
        love.graphics.newFont(16), 
        10,
        love.graphics.getHeight() - 50,
        love.graphics.getWidth()
    )
    --
    if game.state["running"] then
        for i = 1, #enemies do
            enemies[i]:draw()
        end

        love.graphics.circle("fill", player.x, player.y, player.radius)
    elseif game.state["menu"] then
        buttons.menu_state.play_game:draw(10, 20, 17, 10)
        buttons.menu_state.settings:draw(10, 70, 17, 10)
        buttons.menu_state.exit_game:draw(10, 120, 17, 10)
    end

    if not game.state["running"] then
        love.graphics.circle("fill", player.x, player.y, player.radius / 2)
    end
end
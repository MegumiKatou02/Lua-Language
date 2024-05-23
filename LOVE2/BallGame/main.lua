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
    },
    score = 0
}

local player = {
    radius = 20,
    x = 30,
    y = 30,
}

local standardScore = 5

local buttons = {
    menu_state = {},
    ended_sate = {}
}

local enemies = {}

local function ChangeGameState(state)
    game.state["menu"] = state == "menu"
    game.state["pause"] = state == "pause"
    game.state["running"] = state == "running"
    game.state["ended"] = state == "ended"
end

local function StartNewGame()
    ChangeGameState("running")
    game.score = 0
    enemies = {}
    table.insert(enemies, 1, enemy())
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        if game.state["menu"] then
            for index in pairs(buttons.menu_state) do
                buttons.menu_state[index]:checkPressed(x, y,  player.radius)
            end
        elseif game.state["ended"] then
            for index in pairs(buttons.ended_sate) do
                buttons.ended_sate[index]:checkPressed(x, y,  player.radius)
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
                ChangeGameState("ended")
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

    buttons.ended_sate.replay_game = button("Replay Game", StartNewGame, nil, 120, 40)
    buttons.ended_sate.menu = button("Menu", ChangeGameState, "menu", 120, 40)
    buttons.ended_sate.exit_game = button("Exit Game", love.event.quit, nil, 120, 40)
end

function love.update(dt)
    gameover() -- checked game over
    player.x, player.y = love.mouse.getPosition()

    if game.state["running"] then
        for i = 1, #enemies do
            enemies[i]:move(player.x, player.y)
        end
        game.score = game.score + dt
        if game.score >= standardScore then
            table.insert(enemies, #enemies + 1, enemy())
            standardScore = standardScore + 15
            for i = 1, #enemies do
                enemies[i].level = enemies[i].level + 0.5
            end
        end
    end
end

function love.draw()
    -- print the score
    if game.state["running"] then
        love.graphics.printf(
            "Score: " .. math.floor(game.score), 
            love.graphics.newFont(16),
            0,
            10,
            love.graphics.getWidth(),
            "center"
        )
    end
    -- state
    --
    love.graphics.printf(
        "FPS: " .. love.timer.getFPS(), 
        love.graphics.newFont(16), 
        10, 
        love.graphics.getHeight() - 30,
        love.graphics.getWidth()
    )
    if game.state["running"] then
        -- print the enemies's number
        love.graphics.printf(
            "Enemies: " .. #enemies,
            love.graphics.newFont(16), 
            10,
            love.graphics.getHeight() - 50,
            love.graphics.getWidth()
        )
        --
        for i = 1, #enemies do
            enemies[i]:draw()
        end

        love.graphics.circle("fill", player.x, player.y, player.radius)
    elseif game.state["menu"] then
        buttons.menu_state.play_game:draw(10, 20, 17, 10)
        buttons.menu_state.settings:draw(10, 70, 17, 10)
        buttons.menu_state.exit_game:draw(10, 120, 17, 10)
    elseif game.state["ended"] then
        buttons.ended_sate.replay_game:draw(love.graphics.getWidth() / 2.25, love.graphics.getHeight() / 1.8, 17, 10)
        buttons.ended_sate.menu:draw(love.graphics.getWidth() / 2.25, love.graphics.getHeight() / 1.54, 17, 10)
        buttons.ended_sate.exit_game:draw(love.graphics.getWidth() / 2.25, love.graphics.getHeight() / 1.33, 17, 10)
        -- draw point
        love.graphics.printf(
            "Your score: " .. math.floor(game.score),
            love.graphics.newFont(20), 
            love.graphics.getWidth() / 2.25,
            love.graphics.getHeight() / 1.8 - 70,
            love.graphics.getWidth()
        )
    end

    if not game.state["running"] then
        love.graphics.circle("fill", player.x, player.y, player.radius / 2)
    end
end
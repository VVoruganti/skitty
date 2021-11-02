-- Implementation of the mobile game flappy bird
pipes = require("pipes")
player = require("player")

function love.load()
    math.randomseed(os.time())


    pipes.gameHeight = love.graphics.getHeight()
    pipes.gameWidth = love.graphics.getWidth()

    love.graphics.setBackgroundColor(0.41,0.53,0.97)
    pipes:addPipe()

    Score = 0
end

function love.keypressed(key, scancode, isrepeat)
    if(scancode == "space") then
        player:handleInput()
    end
end

function love.update(dt)
    pipes:update(dt)
    player:update(dt)
end

function love.draw()
    pipes:draw()
    player:draw()
end



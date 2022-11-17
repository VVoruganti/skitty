-- Implementation of the game pong in love2d

-- load our assets
function love.load()
    -- initialize environment
    local newFont = love.graphics.newFont(20) -- default bigger font
    love.graphics.setFont(newFont) -- set the new font
    love.graphics.setBackgroundColor(0.9,0.6,0) -- set background color for window
    love.keyboard.setKeyRepeat(true) -- makes it so you can hold down a key and it will be registered repeatedly

    -- initialize variables
    User, Ai, Ball = {}, {}, {} -- initialize empty tables for game objects
    User.x, User.y, Ai.x, Ai.y = 5, love.graphics.getHeight()/2, 1000, love.graphics.getHeight()/2 -- main variables to use for tracking entities
    Ball.x, Ball.y = love.graphics.getWidth()/2, love.graphics.getHeight()/2 -- variables for the ball entity location 
    Ball.vx, Ball.vy = -5, math.random(-5,5) -- initialize ball velocity
    User.points, Ai.points = 0, 0 -- initial scores for each player
    Multiplier = 0
end

-- update event
function love.update(dt)
    -- user movement
    if love.keyboard.isDown("up") and (User.y - 5 > 0)  then
        User.y = User.y - (5 + Multiplier * 0.05)
        Multiplier = Multiplier + 1
    elseif love.keyboard.isDown("down") and (User.y + 5 + 100 < love.graphics.getPixelHeight()) then
        User.y = User.y + (5 + Multiplier * 0.05)
        Multiplier = Multiplier + 1
    else
        Multiplier = 0
    end
    -- ai movement
    if love.keyboard.isDown("w") and (Ai.y -5 > 0) then
        Ai.y = Ai.y - 5
    elseif love.keyboard.isDown("s") and (Ai.y + 5 + 100 < love.graphics.getPixelHeight()) then
        Ai.y = Ai.y + 5
    end
    -- bounds checking booleans
    local userBound = (User.x + 10 >= Ball.x - 10) and (User.y <= Ball.y and Ball.y <= User.y + 100)
    local aiBound = (Ai.x <= Ball.x + 10) and (Ai.y <= Ball.y and Ball.y <= Ai.y + 100)
    local topBound = (Ball.y - 10 <= 0)
    local bottomBound = (Ball.y + 10 >= love.graphics.getPixelHeight())
    -- change ball vector depending on if a bound is hit 
    if userBound then
        Ball.vx = Ball.vx * -(1 + math.random(-0.2, 0.2))
        local delta = ((Ball.y - User.y) / 100 * 2) + -1
        Ball.vy = Ball.vy + delta
    elseif aiBound then
        Ball.vx = Ball.vx * -(1 + math.random(-0.2, 0.2))
        local delta = ((Ball.y - Ai.y) / 100 * 2) + -1
        Ball.vy = Ball.vy + delta
    elseif topBound or bottomBound then
        Ball.vy = Ball.vy * -1
    end
    -- update location of ball
    Ball.x = Ball.x + Ball.vx
    Ball.y = Ball.y + Ball.vy
    -- score checking and resetting ball location
    if(Ball.x < 0) then
        Ai.points = Ai.points + 1
        -- variables for the ball entity location
        Ball.x, Ball.y = love.graphics.getWidth()/2, love.graphics.getHeight()/2
        Ball.vx = if (math.random() > 0.5) then (5) else (-5) end
        Ball.vy = math.random(-5,5)
    elseif(Ball.x > love.graphics.getWidth()) then
        User.points = User.points + 1
        Ball.x, Ball.y = love.graphics.getWidth()/2, love.graphics.getHeight()/2 -- variables for the ball entity location 
        Ball.vx = if math.random() > 0.5 then 5 else -5 end
        Ball.vy = math.random(-5,5)
    end
end

-- just code for rendering image
function love.draw()
    -- scores
    love.graphics.print(User.points, 10, 10)
    love.graphics.print(Ai.points, love.graphics.getWidth() - 20, 10)
    -- user rectangle
    love.graphics.setColor(0,0.4,0.4) -- color of rectangle
    love.graphics.rectangle("fill", User.x, User.y, 10, 100)
    -- AI rectangle
    love.graphics.setColor(0,0.4,0.4)
    love.graphics.rectangle("fill", Ai.x, Ai.y, 10, 100)
    -- Ball --
    love.graphics.setColor(0.9,0.9,0.9)
    love.graphics.ellipse("fill", Ball.x, Ball.y, 20, 20)
end



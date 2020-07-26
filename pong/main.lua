-- Implementation of the game pong in love2d

-- load our assets
function love.load()
    -- initialize environment
    local newFont = love.graphics.newFont(20) -- default bigger font
    love.graphics.setFont(newFont) -- set the new font
    love.graphics.setBackgroundColor(0.9,0.6,0) -- set background color for window
    love.keyboard.setKeyRepeat(true) -- makes it so you can hold down a key and it will be registered repeatedly

    -- initialize variables
    user, ai, ball = {}, {}, {} -- initialize empty tables for game objects
    user.x, user.y, ai.x, ai.y = 5, love.graphics.getHeight()/2, 1000, love.graphics.getHeight()/2 -- main variables to use for tracking entities
    ball.x, ball.y = love.graphics.getWidth()/2, love.graphics.getHeight()/2 -- variables for the ball entity location 
    ball.vx, ball.vy = -5, math.random(-5,5) -- initialize ball velocity
    user.points, ai.points = 0, 0 -- initial scores for each player
    multiplier = 0
end

-- update event
function love.update(dt)
    -- user movement
    if love.keyboard.isDown("up") and (user.y - 5 > 0)  then
        user.y = user.y - (5 + multiplier * 0.05)
        multiplier = multiplier + 1
    elseif love.keyboard.isDown("down") and (user.y + 5 + 100 < love.graphics.getPixelHeight()) then
        user.y = user.y + (5 + multiplier * 0.05)
        multiplier = multiplier + 1
    else
        multiplier = 0
    end
    -- ai movement
    if love.keyboard.isDown("w") and (ai.y -5 > 0) then
        ai.y = ai.y - 5
    elseif love.keyboard.isDown("s") and (ai.y + 5 + 100 < love.graphics.getPixelHeight()) then
        ai.y = ai.y + 5
    end
    -- bounds checking booleans
    userBound = (user.x + 10 >= ball.x - 10) and (user.y <= ball.y and ball.y <= user.y + 100)
    aiBound = (ai.x <= ball.x + 10) and (ai.y <= ball.y and ball.y <= ai.y + 100)
    topBound = (ball.y - 10 <= 0)  
    bottomBound = (ball.y + 10 >= love.graphics.getPixelHeight())
    -- change ball vector depending on if a bound is hit 
    if userBound then
        ball.vx = ball.vx * -(1 + math.random(-0.2, 0.2))
        delta = ((ball.y - user.y) / 100 * 2) + -1
        ball.vy = ball.vy + delta
    elseif aiBound then
        ball.vx = ball.vx * -(1 + math.random(-0.2, 0.2))        
        delta = ((ball.y - ai.y) / 100 * 2) + -1
        ball.vy = ball.vy + delta
    elseif topBound or bottomBound then
        ball.vy = ball.vy * -1
    end
    -- update location of ball
    ball.x = ball.x + ball.vx
    ball.y = ball.y + ball.vy
    -- score checking and resetting ball location
    if(ball.x < 0) then
        ai.points = ai.points + 1
        -- variables for the ball entity location
        ball.x, ball.y = love.graphics.getWidth()/2, love.graphics.getHeight()/2  
        ball.vx = if (math.random() > 0.5) then (5) else (-5) end
        ball.vy = math.random(-5,5)
    elseif(ball.x > love.graphics.getWidth()) then
        user.points = user.points + 1
        ball.x, ball.y = love.graphics.getWidth()/2, love.graphics.getHeight()/2 -- variables for the ball entity location 
        ball.vx = if math.random() > 0.5 then 5 else -5 end
        ball.vy = math.random(-5,5)
    end
end

-- just code for rendering image
function love.draw()
    -- scores
    love.graphics.print(user.points, 10, 10)
    love.graphics.print(ai.points, love.graphics.getWidth() - 20, 10)
    -- user rectangle
    love.graphics.setColor(0,0.4,0.4) -- color of rectangle
    love.graphics.rectangle("fill", user.x, user.y, 10, 100)
    -- AI rectangle
    love.graphics.setColor(0,0.4,0.4)
    love.graphics.rectangle("fill", ai.x, ai.y, 10, 100)
    -- Ball --
    love.graphics.setColor(0.9,0.9,0.9)
    love.graphics.ellipse("fill", ball.x, ball.y, 20, 20)
end



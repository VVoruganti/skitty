
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()
    userX, userY, aiX, aiY = 5, 500, 100, 500
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
end

function love.keypressed(key)
    -- keys can be accessed by string name
    if key == 'escape' then
        -- function LOVE gives us to terminate application
        love.event.quit()
    end
end

function love.update(dt)
end

function love.draw()
    love.graphics.setColor(0,0.4,0.4)
    love.graphics.rectangle("fill", userX, userY, 10, 100)
end



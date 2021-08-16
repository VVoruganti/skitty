--[[
-- Implementation of Tetris in Love2D
]]--

WINDOW_WIDTH = 500
WINDOW_HEIGHT = 500

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
    Grid_Settings = {x=10, 100}
    Grid = {}
    Stepx = WINDOW_WIDTH / Grid_Settings.x
    Stepy = WINDOW_WIDTH / Grid_Settings.y
    -- initialize Grid as a matrix
    for i = 1, Grid_Settings.x do
        Grid[i] = {}
        for j = 1, Grid_Settings.y do
            Grid[i][j] = -1
        end
    end
    State = "Load"
end


function love.update(dt)
    if State == "Load" and love.keyboard.isDown("return") then
        State = "Play"
    end
end

function love.draw()
    -- Draw grid
    love.graphics.setColor(1,1,1)
    for i = 1, Grid_Settings.x - 1 do
        love.graphics.line(i * Stepx, 0, i * Stepx, WINDOW_HEIGHT)
    end
    for i = 1, Grid_Settings.y - 1 do
        love.graphics.line(0, i*Stepy, WINDOW_WIDTH, i*Stepy)
    end

end



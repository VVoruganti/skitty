--[[
-- Implementation of Conway's game of life in Love2D
]]--

WINDOW_WIDTH = 500
WINDOW_HEIGHT = 500

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
    Grid_Settings = {x=10, y=10}
    Grid = {}
    Stepx = WINDOW_WIDTH / Grid_Settings.x
    Stepy = WINDOW_HEIGHT / Grid_Settings.y
    -- initialize Grid as a matrix
--     for i = 1, Grid_Settings.x do
--         Grid[i] = {}
--         for j = 1, Grid_Settings.y do
--             Grid[i][j] = 0
--         end
--     end
    Grid = {{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 1, 1, 0, 0, 0, 0, 0, 0},
            {0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 1, 1, 0, 0, 0, 0, 0, 0},
            {0, 1, 0, 1, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
            }
    State = "Play"
    Timer = 0
end

function sumNeighbors(x,y)
    local sum = 0
    for i = x - 1, x + 1 do
        for j = y - 1, y + 1 do
            if i > 0 and i <= Grid_Settings.x and j > 0 and j <= Grid_Settings.y and Grid[i][j] == 1 then
                sum = sum + 1
            end
        end
    end
    return sum
end


function conway()
    local nodes = 0
    for i = 1, Grid_Settings.x do
        for j = 1, Grid_Settings.y do
            local sum = sumNeighbors(i,j)
            if Grid[i][j] == 1 then
                nodes = nodes + 1
                if sum < 2 or sum > 3 then
                    Grid[i][j] = 0
                end
            elseif Grid[i][j] == 0 and sum == 3 then
                Grid[i][j] = 1
            end
        end
    end
    return nodes
end

function love.update(dt)
    if State == "Load" then

    elseif State == "Play" then
        -- Update timer
        Timer = Timer + dt
        -- Run Game of Life every 2 seconds
        if Timer > 2 then
            Timer = 0
            local statistic = conway()
            -- Check if the game is over
            if(statistic == 0) then
                State = "End"
            end
        end
    else end
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
    -- Draw Nodes
    if State == "Play" then
        love.graphics.setColor(1,0,0)
        for i = 1, Grid_Settings.x do
            for j = 1, Grid_Settings.y do
                if Grid[i][j] == 1 then
                    love.graphics.rectangle("fill", (i-1)*Stepx, (j-1)*Stepy, Stepx, Stepy)
                end
            end
        end
    end
end

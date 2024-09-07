-- Implementation of Minesweeper in Love2D

WINDOW_WIDTH = 500
WINDOW_HEIGHT = 500

Mines = {}

function love.load()
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
  Grid_Settings = { x = 10, y = 10 }
  Grid = {}
  Stepx = WINDOW_WIDTH / Grid_Settings.x
  Stepy = WINDOW_HEIGHT / Grid_Settings.y
  -- initialize Grid as a matrix
  for i = 1, Grid_Settings.x do
    Grid[i] = {}
    for j = 1, Grid_Settings.y do
      Grid[i][j] = -1
    end
  end
  State = "Load"
end

function CountAdjacentMines(x, y)
  local count = 0
  for dx = -1, 1 do
    for dy = -1, 1 do
      local nx, ny = x + dx, y + dy
      if nx >= 1 and nx <= Grid_Settings.x and ny >= 1 and ny <= Grid_Settings.y then
        if Grid[nx][ny] == 9
        then
          count = count + 1
        end
      end
    end
    return count
  end
end

function love.update(dt)
  if State == "Load" then
    -- Initialize mines
    for i = 1, 10 do
      local x = love.math.random(1, Grid_Settings.x)
      local y = love.math.random(1, Grid_Settings.y)
      Grid[x][y] = 9 -- 9 represents a mine
    end
    State = "Play"
  elseif State == "Play" then
    -- Handle game logic for Play state
    if love.mouse.isDown(1) then
      local x = math.floor(love.mouse.getX() / Stepx) + 1
      local y = math.floor(love.mouse.getY() / Stepy) + 1
      if Grid[x][y] == 9 then
        State = "GameOver"
      elseif Grid[x][y] == -1 then
        Grid[x][y] = CountAdjacentMines(x, y)
      end
    end
  end
end

function love.draw()
  -- Draw Grid
  for i = 1, Grid_Settings.x - 1 do
    love.graphics.line(i * Stepx, 0, i * Stepx, WINDOW_HEIGHT)
  end
  for i = 1, Grid_Settings.y - 1 do
    love.graphics.line(0, i * Stepy, WINDOW_WIDTH, i * Stepy)
  end
end

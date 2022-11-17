local ball = require("ball")
local platform = require("platform")
local levels = require("levels")
local bricks = require("bricks")
local walls = require("walls")
local collisions = require("collisions")

function love.keyreleased(key, code)
  if key == 'escape' then
    love.event.quit()
  end
end

function love.load()
end

function love.load()
  levels.current_level = 1
  bricks.construct_level(levels.sequence[levels.current_level])
  walls.construct_walls()
end

function love.update(dt)
  ball.update(dt)
  platform.update(dt)
  bricks.update(dt)
  walls.update(dt)

  collisions.resolve_collisions(ball, platform, bricks, walls)
  levels.switch_to_next_level(bricks)
end

function love.draw()
  ball.draw()
  platform.draw()
  bricks.draw()
  walls.draw()
  if levels.gamefinished then
    love.graphics.printf("Congratulations!\n" .. "You have finished the game!", 300, 250, 200, "center")
  end
end

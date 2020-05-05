-- main components for a snake game
-- randomly generated score cubes blue
-- array of objects each with a position value
-- each object moves to the location of the previous
-- control movement of head
-- If head touches tail lose
-- if head touches sides lose
function love.load() -- initial function that loads initializiation code
  nodes = {{x=30,y=0},{x=15,y=0},{x=0,y=0}} -- initializes snake with 3 nodes on it
  obstacle = {x=45,y=45} -- initializes obstacle
  width, height, flags  = love.window.getMode()
  print(width)
  print(height)
  -- variables to use for moving the snake-- 
  x = 15 -- controls the horizontal movement default to moving right
  y = 0 -- controls the vertical movement defaults to not moving vertically

  dead = false
end

function love.update(dt)
  if dt < 1/15 then
    love.timer.sleep(1/15 - dt)
  end

  for i = #nodes, 2, -1 do
    if (nodes[i].x == nodes[1].x and nodes[i].y == nodes[1].y) then
      dead = true
    end
  end

  if nodes[1].x > 800 or nodes[1].x < 0 or nodes[1].y < 0 or nodes[1].y > 600 then
    dead = true
  end

if(not dead) then
  if love.keyboard.isDown("right") then
    x = 15
    y = 0
  elseif love.keyboard.isDown("left") then
    x = -15 
    y = 0
  end

  if love.keyboard.isDown("up") then
    y = -15
    x = 0
  elseif love.keyboard.isDown("down") then
    y = 15
    x = 0
  end
else
  x = 0
  y = 0
end

  if nodes[1].x == obstacle.x and nodes[1].y == obstacle.y then
    nodes[#nodes+1] = {x=0,y=0}
    obstacle.x = math.random(2,20) * 15 
    obstacle.y = math.random(2,20) * 15
  end

  for i = #nodes, 2, -1 do
    nodes[i].x = nodes[i-1].x
    nodes[i].y = nodes[i-1].y
  end
  nodes[1].x = nodes[1].x + x
  nodes[1].y = nodes[1].y + y
end

function love.draw()
    love.graphics.setColor(0,0,255)
    love.graphics.rectangle("fill",nodes[1]["x"],nodes[1]["y"],15,15)
    love.graphics.setColor(255,0,0)
    for i = #nodes , 2, -1 do
      love.graphics.rectangle("fill", nodes[i].x,nodes[i].y,15,15)
    end
    love.graphics.setColor(0,255,0)
    love.graphics.rectangle("fill", obstacle["x"],obstacle["y"],15,15)
    if(dead) then
      love.graphics.print("Dead",400,300)
    end
end



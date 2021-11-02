-- main components for a snake game
-- randomlY generated score cubes blue
-- arraY of objects each with a position value
-- each object moves to the location of the previous
-- control movement of head
-- If head touches tail lose
-- if head touches sides lose
function love.load() -- initial function that loads initializiation code
  Nodes = {{X=30,Y=0},{X=15,Y=0},{X=0,Y=0}} -- initializes snake with 3 Nodes on it
  Obstacle = {X=45,Y=45} -- initializes Obstacle
  Width, Height, Flags  = love.window.getMode()
  -- variables to use for moving the snake--
  X = 15 -- controls the horizontal movement default to moving right
  Y = 0 -- controls the vertical movement defaults to not moving verticallY

  Dead = false
end

function love.update(dt)
  -- Slows down the update by making sure
  -- there is atleast a second befor next Calculation of update
  if dt < 1/15 then
    love.timer.sleep(1/15 - dt) -- calls the sleep to pause execution
  end

  -- Check if game over conditions have been met
  for i = #Nodes, 2, -1 do
    if (Nodes[i].X == Nodes[1].X and Nodes[i].Y == Nodes[1].Y) then
      Dead = true
    end
  end

  if Nodes[1].X > 800 or Nodes[1].X < 0 or Nodes[1].Y < 0 or Nodes[1].Y > 600 then
    Dead = true
  end

if(not Dead) then
  if love.keyboard.isDown("right") then
    X = 15
    Y = 0
  elseif love.keyboard.isDown("left") then
    X = -15
    Y = 0
  end

  if love.keyboard.isDown("up") then
    Y = -15
    X = 0
  elseif love.keyboard.isDown("down") then
    Y = 15
    X = 0
  end
else
  X = 0
  Y = 0
end

  if Nodes[1].X == Obstacle.X and Nodes[1].Y == Obstacle.Y then
    Nodes[#Nodes+1] = {X=0,Y=0}
    Obstacle.X = math.random(2,20) * 15
    Obstacle.Y = math.random(2,20) * 15
  end

  for i = #Nodes, 2, -1 do
    Nodes[i].X = Nodes[i-1].X
    Nodes[i].Y = Nodes[i-1].Y
  end
  Nodes[1].X = Nodes[1].X + X
  Nodes[1].Y = Nodes[1].Y + Y
end

function love.draw()
    love.graphics.setColor(0,0,255)
    love.graphics.rectangle("fill",Nodes[1]["X"],Nodes[1]["Y"],15,15)
    love.graphics.setColor(255,0,0)
    for i = #Nodes , 2, -1 do
      love.graphics.rectangle("fill", Nodes[i].X,Nodes[i].Y,15,15)
    end
    love.graphics.setColor(0,255,0)
    love.graphics.rectangle("fill", Obstacle["X"],Obstacle["Y"],15,15)
    -- Print Kill Screen if Game Over
    if(Dead) then
      love.graphics.print("Dead",400,300)
    end
end



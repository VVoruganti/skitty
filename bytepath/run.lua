-- Question #1 What is the point of vsync in the setMode
-- The vsync setting is used to control the refresh rate of the window. It sets it to match the same
-- refresh rate as the monitor. Not entirely sure where in the code this happens though, but seems like a system
-- level thing?

-- Original love.run function Also #3 Implemenet a Variable Time Loop

local function variable_time_loop()
  if love.load then love.load(love.arg.parseGameArguments(arg), arg) end

  -- We don't want the first frame's dt to include time taken by love.load.
  if love.timer then love.timer.step() end

  local dt = 0

  -- Main loop time.
  return function()
    -- Process events.
    if love.event then
      love.event.pump()
      for name, a, b, c, d, e, f in love.event.poll() do
        if name == "quit" then
          if not love.quit or not love.quit() then
            return a or 0
          end
        end
        love.handlers[name](a, b, c, d, e, f)
      end
    end

    -- Update dt, as we'll be passing it to update
    if love.timer then dt = love.timer.step() end

    -- Call update and draw
    if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled

    if love.graphics and love.graphics.isActive() then
      love.graphics.origin()
      love.graphics.clear(love.graphics.getBackgroundColor())

      if love.draw then love.draw() end

      love.graphics.present()
    end

    if love.timer then love.timer.sleep(0.001) end
  end
end

-- Question #2 Implement a Fixed Delta Time Loop in the love.run function
local function fixed_time_loop()
  if love.load then love.load(love.arg.parseGameArguments(arg), arg) end

  -- We don't want the first frame's dt to include time taken by love.load.
  if love.timer then love.timer.step() end

  local dt = 1 / 60

  -- Main loop time.
  return function()
    -- Process events.
    if love.event then
      love.event.pump()
      for name, a, b, c, d, e, f in love.event.poll() do
        if name == "quit" then
          if not love.quit or not love.quit() then
            return a or 0
          end
        end
        love.handlers[name](a, b, c, d, e, f)
      end
    end

    -- Call update and draw
    if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled

    if love.graphics and love.graphics.isActive() then
      love.graphics.origin()
      love.graphics.clear(love.graphics.getBackgroundColor())

      if love.draw then love.draw() end

      love.graphics.present()
    end

    if love.timer then love.timer.sleep(0.001) end
  end
end

-- Question #4 Implement a Semi-Fixed Timestep
local function semi_fixed_time_loop()
  if love.load then love.load(love.arg.parseGameArguments(arg), arg) end

  -- We don't want the first frame's dt to include time taken by love.load.
  if love.timer then love.timer.step() end

  local dt = 0
  local upper_dt = 1 / 60

  -- Main loop time.
  return function()
    -- Process events.
    if love.event then
      love.event.pump()
      for name, a, b, c, d, e, f in love.event.poll() do
        if name == "quit" then
          if not love.quit or not love.quit() then
            return a or 0
          end
        end
        love.handlers[name](a, b, c, d, e, f)
      end
    end

    -- Update dt, as we'll be passing it to update
    if love.timer then dt = love.timer.step() end


    while (dt > 0) do
      local current_dt = math.min(dt, upper_dt)
      if love.update then love.update(current_dt) end -- will pass 0 if love.timer is disabled
      dt = dt - current_dt
    end

    -- Call update and draw

    if love.graphics and love.graphics.isActive() then
      love.graphics.origin()
      love.graphics.clear(love.graphics.getBackgroundColor())

      if love.draw then love.draw() end

      love.graphics.present()
    end

    if love.timer then love.timer.sleep(0.001) end
  end
end

-- #5 Free the physics loop
local function free_time_loop()
  if love.load then love.load(love.arg.parseGameArguments(arg), arg) end

  -- We don't want the first frame's dt to include time taken by love.load.
  if love.timer then love.timer.step() end

  local upper_dt = 0.01
  local dt = 0
  local acc = 0

  -- Main loop time.
  return function()
    -- Process events.
    if love.event then
      love.event.pump()
      for name, a, b, c, d, e, f in love.event.poll() do
        if name == "quit" then
          if not love.quit or not love.quit() then
            return a or 0
          end
        end
        love.handlers[name](a, b, c, d, e, f)
      end
    end

    -- Update dt, as we'll be passing it to update
    if love.timer then dt = love.timer.step() end
    acc = acc + dt

    while (acc >= upper_dt) do
      if love.update then love.update(upper_dt) end -- will pass 0 if love.timer is disabled
      acc = acc - upper_dt
    end

    -- Call update and draw

    if love.graphics and love.graphics.isActive() then
      love.graphics.origin()
      love.graphics.clear(love.graphics.getBackgroundColor())

      if love.draw then love.draw() end

      love.graphics.present()
    end

    if love.timer then love.timer.sleep(0.001) end
  end
end

-- Implementation of the mobile game flappy bird
WINDOW_WIDTH = 750
WINDOW_HEIGHT = 750

function love.load()
    love.physics.setMeter(64)
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)

    math.randomseed(os.time())

    world = love.physics.newWorld(0, 9.81*64, true)
    objects = {}

    objects.ground = {}
    objects.ground.body = love.physics.newBody(world, WINDOW_WIDTH / 2, WINDOW_HEIGHT - 50 / 2)
    objects.ground.shape = love.physics.newRectangleShape(WINDOW_WIDTH, 50)
    objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)

    objects.player = {}
    objects.player.body = love.physics.newBody(world, 50, WINDOW_HEIGHT / 2, "dynamic")
    objects.player.shape = love.physics.newRectangleShape(0, 0, 100, 50)
    objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape, 1)

    objects.pipes = {}

    love.graphics.setBackgroundColor(0.41,0.53,0.97)

    Score = 0
end

function love.keypressed(key, scancode, is)
    if key == "up" then
        objects.player.body:applyLinearImpulse(0,-9.81*50)
    end
end

function newPipe()
   local r = 10 * math.random(1,10)
   local newPipe = {}
   table.insert(objects.pipes, newPipe)
end

function love.update(dt)
    world:update(dt)
    if dt < 1.5 then
        love.timer.sleep(1.5 - dt)
    end
    newPipe()
end

function love.draw()
    love.graphics.setColor(0.28, 0.63, 0.05)
    love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))

    love.graphics.setColor(0.28, 0.18, 0.05)
    love.graphics.polygon("fill", objects.player.body:getWorldPoints(objects.player.shape:getPoints()))
end



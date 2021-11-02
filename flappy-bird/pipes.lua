local pipes = {}

pipes.gapSize = 100;
pipes.gamePipes = {}
pipes.dt = 0
pipes.gameHeight = 0
pipes.gameWidth = 0

function pipes:addPipe()
    local r = math.random(200,self.gameHeight - 200)
    local pipe = {x = self.gameWidth,
                  gap = r}
    table.insert(self.gamePipes, pipe)
end

function pipes.update(self, dt)
    self.dt = self.dt + dt
    if (self.dt > 2.5) then
        print(self.dt)
        self.dt = 0
        self:addPipe()
    end
    for _, pipe in pairs(self.gamePipes) do
        pipe.x = pipe.x - 2
    end
end

function pipes.draw(self)
    for _, pipe in pairs(self.gamePipes) do
        pipes:draw_pipe(pipe)
    end
end

function pipes.draw_pipe(self, pipe)
    love.graphics.setColor(0,0.28,0)
    love.graphics.rectangle("fill", pipe.x, 0, 50, pipe.gap )
    love.graphics.rectangle("fill", pipe.x, pipe.gap + self.gapSize, 50, self.gameHeight - pipe.gap + self.gapSize)
end

function pipes.checkCollision(bird)
    if(bird.x > 100) then
        return true
    end
end

return pipes

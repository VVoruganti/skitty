local player = {}

player.gameHeight = love.graphics.getHeight()
player.gameWidth = love.graphics.getWidth()
player.x = 50
player.y = 100
player.radius = 15
player.state = "FALLING"
player.dt = 0


function player:handleInput()
    self.dt = 0
    if(self.state == "FALLING") then
        self.state =  "CONTROL"
    end
end

function player:update(dt)
    self.dt = self.dt + dt
    if(self.state == "FALLING") then
        player.y = player.y + 5 + self.dt
    elseif(self.state == "CONTROL") then
        player.y = player.y - 8 + self.dt
        if(self.dt >= 0.25) then
            self.state = "FALLING"
            self.dt = 0
        end
    end
end

function player:draw()
    love.graphics.setColor(0.20, 0, 0)
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

return player

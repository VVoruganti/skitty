local ball = {}
ball.position = {}
ball.speed = {}
ball.position.x = 300
ball.position.y = 300
ball.speed.x = 300
ball.speed.y = 300
ball.radius = 10

function ball.update(dt)
    ball.position.x = ball.position.x + ball.speed.x * dt
    ball.position.y = ball.position.y + ball.speed.y * dt
end

function ball.draw()
    local segments_in_circle = 16
    love.graphics.circle( 'line',
                           ball.position.x,
                           ball.position.y,
                           ball.radius,
                           segments_in_circle)   
end

function ball.rebound( shift_ball )
    local min_shift = math.min( math.abs(shift_ball.x),
                                math.abs(shift_ball.y) )
    if math.abs( shift_ball.x ) == min_shift then
        shift_ball.y = 0
    else
        shift_ball.x = 0
    end
    ball.position.x = ball.position.x + shift_ball.x
    ball.position.y = ball.position.y + shift_ball.y
    if shift_ball.x ~= 0 then
      ball.speed.x = -ball.speed.x
   end
   if shift_ball.y ~= 0 then
      ball.speed.y = -ball.speed.y
   end
end


function ball.wall_rebound( shift_ball )
    local min_shift = math.min( math.abs(shift_ball.x),
                                math.abs(shift_ball.y) )
    if math.abs( shift_ball.x ) == min_shift then
        shift_ball.y = 0
    else
        shift_ball.x = 0
    end
    ball.position.x = ball.position.x + shift_ball.x
    ball.position.y = ball.position.y + shift_ball.y
end

function ball.reposition()
    ball.position.x = 200
    ball.position.y = 500
end

return ball

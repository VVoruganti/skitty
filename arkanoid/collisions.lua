local collisions = {}

-- Implementation of AABB Collision Detection
function collisions.check_rectangles_overlap( a, b )
    local overlap = false
    local shift_b_x, shift_b_y = 0, 0 
    if not( a.x + a.width < b.x  or b.x + b.width < a.x  or
        a.y + a.height < b.y or b.y + b.height < a.y ) then
        overlap = true
        if ( a.x + a.width / 2) < ( b.x + b.width / 2 ) then
            shift_b_x = ( a.x + a.width ) - b.x
        else
            shift_b_x = a.x - ( b.x + b.width )   
        end
        if ( a.y + a.height / 2 ) < ( a.y + a.height ) then
            shift_b_y = ( a.y + a.height+ - b.y )
        else
            shift_b_y = a.y - (b.y + b.height)
        end
   end
   return overlap, shift_b_x, shift_b_y
end

function collisions.ball_platform_collision(ball, platform)
    local a = { x = platform.position_x,
                y = platform.position_y,
                width = platform.width,
                height = platform.height }
    local b = { x = ball.position.x - ball.radius,
                y = ball.position.y - ball.radius,
                width = 2 * ball.radius,
                height = 2* ball.radius }
    local shift_ball = {}
    overlap, shift_ball.x, shift_ball.y = collisions.check_rectangles_overlap( a, b)
    if overlap then
        ball.rebound( shift_ball )
    end
end

function collisions.ball_walls_collision( ball, walls )
    local a = { x = ball.position.x - ball.radius,
                y = ball.position.y - ball.radius,
                width = 2 * ball.radius,
                height = 2* ball.radius }
    for i, wall in pairs( walls.current_level_walls ) do
        local b = { x = wall.position_x,
                    y = wall.position_y,
                    width = wall.width,
                    height = wall.height}
        local shift_ball = {}
        overlap, shift_ball.x, shift_ball.y = collisions.check_rectangles_overlap( a, b)
        if overlap then
            ball.wall_rebound( shift_ball )    
        end
    end
end

function collisions.ball_bricks_collision(ball, bricks)
    local a = { x = ball.position.x - ball.radius,
                y = ball.position.y - ball.radius,
                width = 2 * ball.radius,
                height = 2 * ball.radius }
    for i, brick in pairs( bricks.current_level_bricks) do
        local b = { x = brick.position_x,
                    y = brick.position_y,
                    width = brick.width,
                    height = brick.height }
        shift_ball = {}
        overlap, shift_ball.x, shift_ball.y = collisions.check_rectangles_overlap( a, b )
        if overlap then
            ball.rebound( shift_ball )
            bricks.brick_hit_by_ball( i, brick, shift_ball )
        end
    end
end

function collisions.platform_walls_collision( platform, walls)
    local a = { x = platform.position_x,
                y = platform.position_y,
                width = platform.width,
                height = platform.height }
    for i, wall in pairs( walls.current_level_walls ) do
        local b = { x = wall.position_x,
                    y = wall.position_y,
                    width = wall.width,
                    height = wall.height}
        if collisions.check_rectangles_overlap( a, b ) then
            print( "platform-wall collisions")
        end
    end
end

function collisions.resolve_collisions(ball, platform, bricks, walls)
   collisions.ball_platform_collision( ball, platform )
   collisions.ball_walls_collision( ball, walls )
   collisions.ball_bricks_collision( ball, bricks )
   collisions.platform_walls_collision( platform, walls )
end

return collisions

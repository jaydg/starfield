require("lib.starfield")

function love.load()
    stars = Starfield()

    dtotal = 0
    move_x = 2
    move_y = 1
end

function love.draw()
    stars:draw()
end

function love.update(dt)
    stars:moveCartesian(dt, move_x, move_y)

    dtotal = dtotal + dt
    if dtotal > 3 then
        dtotal = 0
        move_x = math.random(0, 3)
        move_y = math.random(0, 3)
    end
end

require("lib.starfield")

function love.load()
    stars = Starfield()

    move_x = 0
    move_y = 1

    love.mouse.setX(stars.center_x)
    love.mouse.setY(stars.center_y)
end

function love.draw()
    stars:draw()

    love.graphics.print("Cartesian Starfield", 10, love.graphics.getHeight() - 30)
    love.graphics.print("dx: " .. move_x .. "; dy: " .. move_y, 10, love.graphics.getHeight() - 17)
end

function love.update(dt)
    cx = love.graphics.getWidth() / 2
    cy = love.graphics.getHeight() / 2

    mx = love.mouse.getX()
    my = love.mouse.getY()

    if mx < cx - 10 or mx > cx + 10 then
        move_x = math.ceil((mx - cx) / 100)
    else
        move_x = 0
    end

    if my < cy - 10 or my > cy + 10 then
        move_y = math.ceil((my - cy) / 100)
    else
        move_y = 0
    end

    stars:updateCartesian(dt, move_x, move_y)
end

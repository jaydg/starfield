Class = require "lib.hump.class"

Starfield = Class{}

function Starfield:init( count, speed, x, y )
    count = count or 100
    self.x = x or love.graphics.getHeight()
    self.y = y or love.graphics.getWidth()
    self.speed = speed or 0.05

    self.dtotal = 0
    self.stars = {}

    for i=1, count do
        self.stars[i] = {
            x = math.random(5, self.x - 5),
            y = math.random(5, self.y - 5),
            velocity = math.random(3),
            size = math.random(3),
            color = {
                math.random(150, 255),
                math.random(150, 255),
                math.random(150, 255)
            }
        }
   end
end

function Starfield:move(dt, vertical, horizontal)
    vertical = vertical or 0
    horizontal = horizontal or 0

    self.dtotal = self.dtotal + dt

    if self.dtotal < self.speed then
        -- no time to update the stars yet..
        return
    else
        self.dtotal = self.dtotal - self.speed
    end

    for i=1, #self.stars do
        -- horizontal movement
        self.stars[i].x = self.stars[i].x + vertical * self.stars[i].velocity
        if self.stars[i].x > self.x then
            self.stars[i].x = 0
        end

        -- vertical movement
        self.stars[i].y = self.stars[i].y + horizontal * self.stars[i].velocity
        if self.stars[i].y > self.y then
            self.stars[i].y = 0
        end
    end
end

function Starfield:draw()
    local ps = love.graphics.getPointStyle()
    love.graphics.setPointStyle("smooth")

    for i=1, #self.stars do
        love.graphics.setColor(self.stars[i].color)
        love.graphics.setPointSize(self.stars[i].size)
        love.graphics.point(self.stars[i].y, self.stars[i].x)
   end

   love.graphics.setPointStyle(ps)
end

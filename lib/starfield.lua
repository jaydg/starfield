Class = require "lib.hump.class"

Starfield = Class{}

function Starfield:init( count, speed, x, y )
    count = count or 100
    self.x = x or love.graphics.getWidth()
    self.y = y or love.graphics.getHeight()
    self:updateCenter(self.x / 2, self.y / 2)
    self.speed = speed or 0.05
    self.dtotal = 0
    self.stars = {}

    for i=1, count do
        self.stars[i] = {
            velocity = love.math.random(3),
            size = love.math.random(3),
            x = love.math.random(5, self.x - 5),
            y = love.math.random(5, self.y - 5),

            -- polar starfield only:
            angle = math.pi * 2 * love.math.random(),
            distance = love.math.random() * self.max_distance,

            color = {
                love.math.random(150, 255),
                love.math.random(150, 255),
                love.math.random(150, 255)
            }
        }
   end
end

function Starfield:updateCenter(x, y)
    -- required for polar starfields
    self.center_x = x or self.x / 2
    self.center_y = y or self.y / 2
    self.max_distance = math.sqrt(self.center_x * self.center_x
                                  + self.center_y + self.center_y)
end

function Starfield:updateCartesian(dt, horizontal, vertical)
    horizontal = horizontal or 0
    vertical = vertical or 0

    self.dtotal = self.dtotal + dt

    if self.dtotal < self.speed then
        -- no time to update the stars yet..
        return
    else
        self.dtotal = self.dtotal - self.speed
    end

    for i=1, #self.stars do
        -- horizontal movement
        self.stars[i].x = self.stars[i].x + horizontal * self.stars[i].velocity
        if horizontal > 0 and self.stars[i].x > self.x then
            self.stars[i].x = 5
        elseif horizontal < 0 and self.stars[i].x < 0 then
            self.stars[i].x = self.x - 5
        end

        -- vertical movement
        self.stars[i].y = self.stars[i].y + vertical * self.stars[i].velocity
        if vertical > 0 and self.stars[i].y > self.y then
            self.stars[i].y = 5
        elseif vertical < 0 and self.stars[i].y < 0 then
            self.stars[i].y = self.y - 5
        end
    end
end

function Starfield:updatePolar(dt)
    self.dtotal = self.dtotal + dt

    if self.dtotal < self.speed then
        -- no time to update the stars yet..
        return
    else
        self.dtotal = self.dtotal - self.speed
    end

    for i=1, #self.stars do
        self.stars[i].x = self.center_x + self.stars[i].distance
                            * math.sin(self.stars[i].angle)
        self.stars[i].y = self.center_y + self.stars[i].distance
                            * math.cos(self.stars[i].angle)

        self.stars[i].distance = self.stars[i].distance
                                    + self.stars[i].velocity

        if (self.stars[i].x > self.x
                or self.stars[i].x < 0
                or self.stars[i].y > self.y
                or self.stars[i].y < 0) then
            self.stars[i].distance = 15
        end
    end
end

function Starfield:draw()
    local ps = love.graphics.getPointStyle()
    love.graphics.setPointStyle("smooth")

    for i=1, #self.stars do
        love.graphics.setColor(self.stars[i].color)
        love.graphics.setPointSize(self.stars[i].size)
        love.graphics.point(self.stars[i].x, self.stars[i].y)
   end

   love.graphics.setPointStyle(ps)
end

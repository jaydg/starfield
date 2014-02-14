Gamestate = require("lib.hump.gamestate")
require("lib.starfield")

-- one gamestate for each type of starfield
local cartesian = {}
local polar = {}

function cartesian:init()
    self.stars = Starfield()
    self.move_x = 0
    self.move_y = 1
end

function cartesian:mousepressed(x, y, button)
    Gamestate.switch(polar)
end

function cartesian:draw()
    self.stars:draw()
    love.graphics.print("Cartesian Starfield", 10, love.graphics.getHeight() - 17)
end

function cartesian:update(dt)
    cx = love.graphics.getWidth() / 2
    cy = love.graphics.getHeight() / 2

    mx = love.mouse.getX()
    my = love.mouse.getY()

    if mx < cx - 10 or mx > cx + 10 then
        self.move_x = math.ceil((mx - cx) / 100)
    else
        self.move_x = 0
    end

    if my < cy - 10 or my > cy + 10 then
        self.move_y = math.ceil((my - cy) / 100)
    else
        self.move_y = 0
    end

    self.stars:updateCartesian(dt, self.move_x, self.move_y)
end

function polar:init()
    self.stars = Starfield(200, 0.02)
end

function polar:mousepressed(x, y, button)
    Gamestate.switch(cartesian)
end

function polar:draw()
    self.stars:draw()
    love.graphics.print("Polar Starfield", 10, love.graphics.getHeight() - 17)
end

function polar:update(dt)
    mx = love.mouse.getX()
    my = love.mouse.getY()

    self.stars:updateCenter(mx, my)
    self.stars:updatePolar(dt)
end

function love.load()
	Gamestate.registerEvents()
    Gamestate.switch(cartesian)
end

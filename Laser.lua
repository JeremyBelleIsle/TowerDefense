local Laser = {}
Laser.__index = Laser

function Laser.new(x, y, w, h)
    local Laser = setmetatable({}, Laser)

    Laser.x = x
    Laser.y = y
    Laser.w = w
    Laser.h = h
    Laser.clicked = 0

    return Laser
end

function Laser.draw(self)
    local mode = "line"
    if self.clicked % 2 ~= 0 then
        mode = "fill"
    end

    love.graphics.rectangle(mode, self.x, self.y, self.w, self.h)
end

return Laser

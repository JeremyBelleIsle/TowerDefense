local Glace = {}
Glace.__index = Glace

function Glace.new(x, y, w, h)
    local Glace = setmetatable({}, Glace)

    Glace.x = x
    Glace.y = y
    Glace.w = w
    Glace.h = h
    Glace.clicked = 0

    return Glace
end

function Glace.draw(self)
    local mode = "line"
    if self.clicked % 2 ~= 0 then
        mode = "fill"
    end

    love.graphics.rectangle(mode, self.x, self.y, self.w, self.h)
end

return Glace

local Canon = {}
Canon.__index = Canon

function Canon.new(x, y, w, h)
    local Canon = setmetatable({}, Canon)

    Canon.x = x
    Canon.y = y
    Canon.w = w
    Canon.h = h
    Canon.clicked = 0
    return Canon
end

function Canon.draw(X, Y, self)
    local mode = "line"
    if self.clicked % 2 ~= 0 then
        mode = "fill"
    end

    love.graphics.rectangle(mode, X, Y, self.w, self.h)
end

return Canon

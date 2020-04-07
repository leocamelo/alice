local screen = {}

screen.w, screen.h = love.graphics.getDimensions()

function screen:center(rect)
  return (self.w - rect.w) / 2, (self.h - rect.h) / 2
end

function screen:bonds(rect)
  return {w = self.w - rect.w, h = self.h - rect.h}
end

return screen

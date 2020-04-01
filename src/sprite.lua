local anim8 = require('vendor.anim8')

local Sprite = {}
Sprite.__index = Sprite

Sprite.path = 'assets/sprites/%s.png'

function Sprite.new(name, w, h)
  local self = setmetatable({}, Sprite)

  self.image = love.graphics.newImage(self.path:format(name))
  self.grid = anim8.newGrid(w, h, self.image:getDimensions())

  return self
end

function Sprite:anim(speed, ...)
  return anim8.newAnimation(self.grid:getFrames(...), speed)
end

return Sprite

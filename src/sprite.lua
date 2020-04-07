local anim8 = require('vendor.anim8')
local Class = require('src.class')

local Sprite = Class.new()

Sprite.path = 'assets/sprites/%s.png'

function Sprite:init(name, w, h)
  self.image = love.graphics.newImage(string.format(self.path, name))
  self.grid = anim8.newGrid(w, h, self.image:getDimensions())
end

function Sprite:anim(speed, ...)
  return anim8.newAnimation(self.grid:getFrames(...), speed)
end

function Sprite:quad(x, y)
  return self.grid:getFrames(x, y)[1]
end

return Sprite

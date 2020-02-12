local anim8 = require('vendor.anim8')
local Sprite = {}

local path = 'assets/sprites/%s.png'

function Sprite.new(name, w, h)
  local self = {}

  self.image = love.graphics.newImage(string.format(path, name))
  self.grid = anim8.newGrid(w, h, self.image:getDimensions())

  return self
end

return Sprite

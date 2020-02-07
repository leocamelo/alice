local anim8 = require('vendor.anim8')
local Anim = {}

function Anim.new(sprite, speed, ...)
  return anim8.newAnimation(sprite.grid:getFrames(...), speed)
end

return Anim

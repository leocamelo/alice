local anim8 = require('vendor.anim8')

local Anim = {}
Anim.default_speed = 0.1

function Anim.new(sprite, spec, speed)
  local frames = sprite.grid(unpack(spec))
  return anim8.newAnimation(frames, speed or Anim.default_speed)
end

return Anim

local tiny = require('vendor.tiny')
local system = tiny.processingSystem()

system.filter = tiny.requireAll('is_arrow')

local Direction = require('src.direction')

local function collision_filter(ca, cb)
  if cb.entity.is_player then return 'cross'
  elseif cb.entity.is_enemy then return 'touch'
  end
end

function system:process(e, dt)
  local gx, gy = Direction.apply(e, e.direction:to_s(), dt)
  local x, y, _, len = self.physics:move(e.collider, gx, gy, collision_filter)

  if len > 0 then
    self.world:remove(e)
  else
    e:move(x, y)
  end
end

return system

local tiny = require('vendor.tiny')

local system = tiny.processingSystem()

system.filter = tiny.requireAll('is_arrow')

local function collision(c1, c2)
  if c2.entity.is_player then
    return 'cross'
  elseif c2.entity.is_mob then
    return 'touch'
  end
end

function system:process(e, dt)
  local gx, gy = e.collider:apply_speed(e.speed, e.direction:to_s(), dt)
  local x, y, _, len = self.physics:move(e.collider, gx, gy, collision)

  if len > 0 then
    self.world:remove(e)
  else
    e.collider:move(x, y)
  end
end

return system

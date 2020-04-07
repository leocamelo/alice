local tiny = require('vendor.tiny')

local system = tiny.processingSystem()

system.filter = tiny.requireAll('is_mob')

local function collision(c1, c2)
  if c2.entity.is_player or c2.entity.is_mob then
    return 'slide'
  end
end

function system:process(e, dt)
  if e.countdown <= 0 then
    e:reset_countdown()
    e.is_running = not e.is_running

    if e.is_running then
      e.direction.index = math.random(#e.direction.options)
    end
  elseif e.is_running then
    local gx, gy = e.collider:apply_speed(e.speed, e.direction:to_s(), dt)
    e.collider:move(self.physics:move(e.collider, gx, gy, collision))
  end
end

return system

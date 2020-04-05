local tiny = require('vendor.tiny')

local system = tiny.processingSystem()

system.filter = tiny.requireAll('is_player')

local function collision(a, b)
  if b.entity.is_mob then
    return 'slide'
  end
end

function system:process(e, dt)
  local is_running = false

  for i, dir in ipairs(e.direction.options) do
    if love.keyboard.isDown(dir) then
      is_running = true
      e.status.running()
      e.direction.index = i

      local gx, gy = e.collider:apply_speed(e.speed, dir, dt)
      e.collider:move(self.physics:move(e.collider, gx, gy, collision))
      break
    end
  end

  if not is_running then
    e.status.iddle()
  end
end

return system

local tiny = require('vendor.tiny')
local system = tiny.processingSystem()

system.filter = tiny.requireAll('is_player')

local Direction = require('src.direction')

function system:process(e, dt)
  local is_running = false

  for i, dir in ipairs(e.direction.options) do
    if love.keyboard.isDown(dir) then
      e.status.running()
      e.direction.index = i

      local gx, gy = Direction.apply(e, dir, dt)
      e:move(self.physics:move(e.collider, gx, gy, e.collision_filter))

      is_running = true
      break
    end
  end

  if not is_running then
    e.status.iddle()
  end
end

return system

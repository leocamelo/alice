local tiny = require('vendor.tiny')
local Direction = require('src.direction')

local system = tiny.processingSystem()

system.filter = tiny.requireAll('is_player')

local function collision_filter(ca, cb)
  if cb.entity.is_enemy then
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

      local gx, gy = Direction.apply(e, dir, dt)
      e:move(self.physics:move(e.collider, gx, gy, collision_filter))
      break
    end
  end

  if not is_running then
    e.status.iddle()
  end
end

return system

local tiny = require('vendor.tiny')
local system = tiny.processingSystem()

local Observer = require('src.observer')
local observer = Observer.new()

system.filter = tiny.requireAll('status', 'direction', 'x', 'y', 'speed')

function system:process(e, dt)
  local running = false

  for key, value in ipairs(e.directions) do
    if love.keyboard.isDown(value) then
      e.direction = key
      e.status = e.statuses.running
      observer:trigger(value, e, dt)
      running = true
      break
    end
  end

  if not running then
    e.status = e.statuses.iddle
    e.direction = e.directions.down
  end
end

observer:observe('up', function(e, dt)
  e.y = math.max(e.y - e.speed * dt, 0)
end)

observer:observe('down', function(e, dt)
  e.y = math.min(e.y + e.speed * dt, 600 - e.h)
end)

observer:observe('left', function(e, dt)
  e.x = math.max(e.x - e.speed * dt, 0)
end)

observer:observe('right', function(e, dt)
  e.x = math.min(e.x + e.speed * dt, 800 - e.w)
end)

return system

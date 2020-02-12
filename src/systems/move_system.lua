local tiny = require('vendor.tiny')
local system = tiny.processingSystem()

local Observer = require('src.observer')
local observer = Observer.new()

system.filter = tiny.requireAll('x', 'y', 'speed', 'status', 'direction')

function system:process(e, dt)
  local running = false

  for i, dir in ipairs(e.direction.options) do
    if love.keyboard.isDown(dir) then
      e.status.running()
      e.direction.index = i
      observer:trigger(dir, self.physics, e, dt)
      running = true
      break
    end
  end

  if not running then
    e.status.iddle()
    e.direction.down()
  end
end

observer:observe('up', function(physics, e, dt)
  e.x, e.y = physics:move(e, e.x, e.y - e.speed * dt)
end)

observer:observe('down', function(physics, e, dt)
  e.x, e.y = physics:move(e, e.x, e.y + e.speed * dt)
end)

observer:observe('left', function(physics, e, dt)
  e.x, e.y = physics:move(e, e.x - e.speed * dt, e.y)
end)

observer:observe('right', function(physics, e, dt)
  e.x, e.y = physics:move(e, e.x + e.speed * dt, e.y)
end)

return system

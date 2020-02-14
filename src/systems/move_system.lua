local tiny = require('vendor.tiny')
local system = tiny.processingSystem()

system.filter = tiny.requireAll('x', 'y', 'speed', 'status', 'direction')

local deltas = {up = {0, -1}, down = {0, 1}, left = {-1, 0}, right = {1, 0}};

local function apply_deltas(e, dir, dt)
  local dx, dy = unpack(deltas[dir]);
  return e.x + (e.speed * dt * dx), e.y + (e.speed * dt * dy)
end

function system:process(e, dt)
  local running = false

  for i, dir in ipairs(e.direction.options) do
    if love.keyboard.isDown(dir) then
      e.status.running()
      e.direction.index = i
      e.x, e.y = self.physics:move(e, apply_deltas(e, dir, dt))
      running = true
      break
    end
  end

  if not running then
    e.status.iddle()
    e.direction.down()
  end
end

return system

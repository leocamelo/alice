local tiny = require('vendor.tiny')
local system = tiny.processingSystem()

system.filter = tiny.requireAll('is_player')

local vectors = {up = {0, -1}, down = {0, 1}, left = {-1, 0}, right = {1, 0}}

local function apply_dir(e, dir, dt)
  local vx, vy = unpack(vectors[dir])

  local dx = e.speed * dt * vx
  local dy = e.speed * dt * vy

  return e.collider.x + dx, e.collider.y + dy
end

function system:process(e, dt)
  local is_running = false

  for i, dir in ipairs(e.direction.options) do
    if love.keyboard.isDown(dir) then
      e.status.running()
      e.direction.index = i
      e:move(self.physics:move(e.collider, apply_dir(e, dir, dt)))
      is_running = true
      break
    end
  end

  if not is_running then
    e.status.iddle()
  end
end

return system

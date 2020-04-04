local Enum = require('src.enum')

local Direction = Enum.new('up', 'down', 'left', 'right')
local vectors = {up = {0, -1}, down = {0, 1}, left = {-1, 0}, right = {1, 0}}

function Direction.apply(e, dir, dt)
  local vx, vy = unpack(vectors[dir])

  local dx = e.speed * dt * vx
  local dy = e.speed * dt * vy

  return e.collider.x + dx, e.collider.y + dy
end

return Direction

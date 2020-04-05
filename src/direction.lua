local Enum = require('src.enum')

local Direction = Enum.new('up', 'down', 'left', 'right')

Direction.vectors = {
  up = {0, -1},
  down = {0, 1},
  left = {-1, 0},
  right = {1, 0}
}

return Direction

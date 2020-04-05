local Class = require('src.class')
local Direction = require('src.direction')

local Collider = Class.new()

function Collider:init(entity)
  self.entity = entity

  self.w = entity.collider_w or entity.w
  self.h = entity.collider_h or entity.h

  self.offset = {
    x = (entity.w - self.w) / 2,
    y = entity.h - self.h
  }

  self.x = entity.x + self.offset.x
  self.y = entity.y + self.offset.y
end

function Collider:apply_speed(speed, dir, dt)
  local vx, vy = unpack(Direction.vectors[dir])

  local dx = speed * dt * vx
  local dy = speed * dt * vy

  return self.x + dx, self.y + dy
end

function Collider:move(x, y)
  self.x = x
  self.y = y

  self.entity.x = x - self.offset.x
  self.entity.y = y - self.offset.y

  if self.on_move then
    self.on_move(self.entity)
  end
end

return Collider

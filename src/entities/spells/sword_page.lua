local Direction = require('src.direction')

local Spell = {}
Spell.__index = Spell

Spell.is_spell = true

Spell.w = 32
Spell.h = 32
Spell.speed = 500

function Spell.new(player)
  local self = setmetatable({}, Spell)

  self.player = player

  self.dir = player.direction:to_s()
  self.collider = {entity = self, w = self.w, h = self.h}

  local offset = self:player_offset()
  self:move(player.x + offset.x, player.y + offset.y)

  return self
end

function Spell:player_offset()
  if self.dir == 'up' then
    return {
      x = (self.player.w - self.w) / 2,
      y = -self.player.spell_offset
    }
  elseif self.dir == 'down' then
    return {
      x = (self.player.w - self.w) / 2,
      y = self.player.h + self.player.spell_offset
    }
  elseif self.dir == 'left' then
    return {
      x = -self.player.spell_offset - self.w,
      y = self.player.collider_offset.y
    }
  elseif self.dir == 'right' then
    return {
      x = self.player.w + self.player.spell_offset,
      y = self.player.collider_offset.y
    }
  end
end

function Spell:update(physics, dt)
  local gx, gy = Direction.apply(self, self.dir, dt)
  self:move(physics:move(self.collider, gx, gy, self.collision_filter))
end

function Spell:move(x, y)
  self.x = x
  self.y = y

  self.collider.x = x
  self.collider.y = y
end

function Spell:collision_filter(other)
  if other.entity.is_player then return 'cross'
  elseif other.entity.is_enemy then return 'touch'
  end
end

return Spell

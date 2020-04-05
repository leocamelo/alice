local Class = require('src.class')
local Collider = require('src.collider')

local Spell = Class.new()

Spell.is_spell = true
Spell.is_arrow = true
Spell.is_stack = true
Spell.is_transient = true

Spell.w = 32
Spell.h = 32
Spell.speed = 500

function Spell:init(player)
  self.player = player
  self.direction = player.direction:clone()

  local ox, oy = self:player_offset()
  self.x = player.x + ox
  self.y = player.y + oy

  self.collider = Collider.new(self)
  self.countdown = 0.5
end

function Spell:player_offset()
  local direction = self.direction
  local player = self.player

  if direction.is_up() then
    return (player.w - self.w) / 2, -player.spell_offset
  elseif direction.is_down() then
    return (player.w - self.w) / 2, player.h + player.spell_offset
  elseif direction.is_left() then
    return -player.spell_offset - self.w, (player.h - self.h) / 2
  elseif direction.is_right() then
    return player.w + player.spell_offset, (player.h - self.h) / 2
  end
end

return Spell

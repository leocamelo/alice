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
  local offset = player.spell_offset

  local center_x = (player.w - self.w) / 2
  local center_y = (player.h - self.h) / 2

  if direction.is_up() then
    return center_x, player.collider.offset.y - self.h - offset
  elseif direction.is_down() then
    return center_x, player.h + offset
  elseif direction.is_left() then
    return player.collider.offset.x - self.w - offset, center_y
  elseif direction.is_right() then
    return player.w + offset, center_y
  end
end

function Spell:raw_draw()
  local r = self.w / 2
  local x = self.x + r
  local y = self.y + r

  love.graphics.circle('fill', x, y, r)
  love.graphics.setColor(0.12, 0.13, 0.2)
  love.graphics.setLineWidth(3)
  love.graphics.circle('line', x, y, r)
end

return Spell

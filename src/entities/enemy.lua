local Class = require('src.class')
local Sprite = require('src.sprite')

local Enemy = Class.new()

Enemy.is_enemy = true

Enemy.w = 64
Enemy.h = 128
Enemy.sprite = Sprite.new('enemy', Enemy.w, Enemy.h)

function Enemy:init(x, y)
  self.collider = {entity = self, w = self.w, h = self.h}
  self:move(x, y)
end

function Enemy:move(x, y)
  self.x = x
  self.y = y

  self.collider.x = x
  self.collider.y = y
end

function Enemy:quad()
  return self.sprite:quad(1, 1)
end

return Enemy

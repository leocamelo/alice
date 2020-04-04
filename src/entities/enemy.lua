local Sprite = require('src.sprite')

local Enemy = {}
Enemy.__index = Enemy

Enemy.is_enemy = true

Enemy.w = 64
Enemy.h = 128
Enemy.sprite = Sprite.new('enemy', Enemy.w, Enemy.h)
Enemy.anims = {Enemy.sprite:anim(1, 1, 1)}

function Enemy.new(x, y)
  local self = setmetatable({}, Enemy)

  self.collider = {entity = self, w = self.w, h = self.h}
  self:move(x, y)

  return self
end

function Enemy:move(x, y)
  self.x = x
  self.y = y

  self.collider.x = x
  self.collider.y = y
end

function Enemy:anim()
  return self.anims[1]
end

return Enemy

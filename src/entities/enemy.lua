local Sprite = require('src.sprite')
local Anim = require('src.anim')

local Enemy = {}
Enemy.__index = Enemy

Enemy.is_enemy = true

Enemy.w = 64
Enemy.h = 128
Enemy.sprite = Sprite.new('enemy', Enemy.w, Enemy.h)
Enemy.anims = { Anim.new(Enemy.sprite, 1, 1, 1) }

function Enemy.new(x, y)
  local self = setmetatable({}, Enemy)

  self.x = x
  self.y = y

  self.collider = { x = x, y = y, w = self.w, h = self.h }

  return self
end

function Enemy:anim()
  return self.anims[1]
end

return Enemy

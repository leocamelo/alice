local Class = require('src.class')
local Sprite = require('src.sprite')
local Collider = require('src.collider')

local Mob = Class.new()

Mob.is_mob = true
Mob.is_stack = true

Mob.w = 64
Mob.h = 57
Mob.speed = 200

Mob.collider_w = 56
Mob.collider_h = 32

Mob.sprite = Sprite.new('mob', Mob.w, Mob.h)
Mob.anims = {Mob.sprite:anim(0.2, '1-4', '1-4')}

function Mob:init(x, y)
  self.x = x
  self.y = y

  self.collider = Collider.new(self)
end

function Mob:anim()
  return self.anims[1]
end

return Mob

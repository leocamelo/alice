local Class = require('src.class')
local Sprite = require('src.sprite')
local Direction = require('src.direction')
local Collider = require('src.collider')

local Mob = Class.new()

Mob.is_mob = true
Mob.is_stack = true

Mob.w = 64
Mob.h = 57
Mob.speed = 50
Mob.countdown_cicle = 3

Mob.collider_w = 56
Mob.collider_h = 32

Mob.sprite = Sprite.new('mob', Mob.w, Mob.h)

function Mob:init(x, y)
  self.x = x
  self.y = y

  self.is_running = false
  self.direction = Direction:case(({'left', 'right'})[math.random(2)])

  self.collider = Collider.new(self)

  self.anims = {right = self.sprite:anim(0.1, '1-4', '1-4')}
  self.anims.left = self.anims.right:clone():flipH()

  self:reset_countdown()
end

function Mob:reset_countdown()
  self.countdown = math.random(self.countdown_cicle)
end

function Mob:anim()
  if self.direction.is_left() or self.direction.is_right() then
    self.cached_anim = self.anims[self.direction:to_s()]
  end
  return self.cached_anim
end

return Mob

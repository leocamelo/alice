local Enum = require('src.enum')
local Class = require('src.class')
local Sprite = require('src.sprite')
local Direction = require('src.direction')
local Collider = require('src.collider')

local Status = Enum.new('iddle', 'running')

local Player = Class.new()

Player.is_player = true
Player.is_stack = true

Player.w = 64
Player.h = 64
Player.speed = 300
Player.max_hp = 10

Player.collider_w = 32
Player.collider_h = 32

Player.card_offset = 16
Player.spell_offset = 8

Player.sprite = Sprite.new('player', Player.w, Player.h)

function Player:init(joystick, x, y)
  self.joystick = joystick

  self.x = x
  self.y = y

  self.hp = self.max_hp

  self.status = Status.iddle()
  self.direction = Direction.down()

  self.collider = Collider.new(self)
  self.collider.on_move = self.move_card

  self.anims = {
    iddle = {
      up = self.sprite:anim(0.1, '1-4', 1),
      down = self.sprite:anim(0.1, '1-4', 2),
      right = self.sprite:anim(0.1, '1-4', 3)
    },
    running = {
      up = self.sprite:anim(0.1, '1-4', 4),
      down = self.sprite:anim(0.1, '1-4', 5),
      right = self.sprite:anim(0.1, '1-4', 6)
    }
  }
  self.anims.iddle.left = self.anims.iddle.right:clone():flipH()
  self.anims.running.left = self.anims.running.right:clone():flipH()
end

function Player:move_card()
  if self.card then
    self.card.x = self.x + self.card_offset
    self.card.y = self.y - (self.card.h + self.card_offset)
  end
end

function Player:set_card(card)
  self.card = card
  self:move_card()
end

function Player:anim()
  return self.anims[self.status:to_s()][self.direction:to_s()]
end

return Player

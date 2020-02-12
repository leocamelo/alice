local Enum = require('src.enum')
local Sprite = require('src.sprite')
local Anim = require('src.anim')

local Status = Enum.new('iddle', 'running')
local Direction = Enum.new('up', 'down', 'left', 'right')

local Player = {}
Player.__index = Player

Player.w = 84
Player.h = 84
Player.speed = 300
Player.sprite = Sprite.new('player', Player.w, Player.h)

Player.anims = {
  iddle_down = Anim.new(Player.sprite, 0.4, '1-4', 1),

  running_up = Anim.new(Player.sprite, 0.1, '2-6', 2),
  running_down = Anim.new(Player.sprite, 0.1, '5-8', 1, 1, 2),
  running_left = Anim.new(Player.sprite, 0.1, '5-8', 3, '1-2', 4),
  running_right = Anim.new(Player.sprite, 0.1, '7-8', 2, '1-4', 3),

  attacking_up = Anim.new(Player.sprite, 0.1, '6-8', 4),
  attacking_down = Anim.new(Player.sprite, 0.1, '3-5', 4),
  attacking_left = Anim.new(Player.sprite, 0.1, '4-6', 5),
  attacking_right = Anim.new(Player.sprite, 0.1, '1-3', 5)
}

function Player.new(x, y)
  local self = setmetatable({}, Player)

  self.x = x
  self.y = y

  self.status = Status.iddle()
  self.direction = Direction.down()

  self.is_attacking = false

  return self
end

function Player:anim()
  local status = self.is_attacking and 'attacking' or self.status:to_s()
  return self.anims[string.format('%s_%s', status, self.direction:to_s())]
end

return Player

local Enum = require('src.enum')
local Sprite = require('src.sprite')
local Anim = require('src.anim')

local Player = {}
Player.__index = Player

Player.w = 84
Player.h = 84
Player.speed = 200

Player.statuses = Enum.new('iddle', 'running')
Player.directions = Enum.new('up', 'down', 'left', 'right')

Player.sprite = Sprite.new('player', Player.w, Player.h)

Player.anims = {
  iddle_down = Anim.new(Player.sprite, {'1-4', 1}, 0.5),
  running_up = Anim.new(Player.sprite, {'2-6', 2}),
  running_down = Anim.new(Player.sprite, {'5-8', 1, 1, 2}),
  running_left = Anim.new(Player.sprite, {'5-8', 3, '1-2', 4}),
  running_right = Anim.new(Player.sprite, {'7-8', 2, '1-4', 3})
}

function Player.new(x, y)
  local self = setmetatable({}, Player)

  self.x = x
  self.y = y

  self.status = self.statuses.iddle
  self.direction = self.directions.down

  return self
end

function Player:anim()
  local status = self.statuses[self.status]
  local direction = self.directions[self.direction]

  return self.anims[string.format('%s_%s', status, direction)]
end

return Player

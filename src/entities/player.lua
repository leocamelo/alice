local Enum = require('src.enum')
local Sprite = require('src.sprite')
local Anim = require('src.anim')

local Status = Enum.new('iddle', 'running')
local Direction = Enum.new('up', 'down', 'left', 'right')

local Player = {}
Player.__index = Player

Player.is_player = true

Player.w = 64
Player.h = 64
Player.speed = 300
Player.sprite = Sprite.new('player', Player.w, Player.h)

Player.anims = {
  iddle = {
    up = Anim.new(Player.sprite, 0.1, '1-4', 1),
    down = Anim.new(Player.sprite, 0.1, '1-4', 2),
    right = Anim.new(Player.sprite, 0.1, '1-4', 3)
  },
  running = {
    up = Anim.new(Player.sprite, 0.1, '1-4', 4),
    down = Anim.new(Player.sprite, 0.1, '1-4', 5),
    right = Anim.new(Player.sprite, 0.1, '1-4', 6)
  }
}

Player.anims.iddle.left = Player.anims.iddle.right:clone():flipH()
Player.anims.running.left = Player.anims.running.right:clone():flipH()

function Player.new(x, y)
  local self = setmetatable({}, Player)

  self.x = x
  self.y = y

  self.status = Status.iddle()
  self.direction = Direction.down()

  return self
end

function Player:anim()
  return self.anims[self.status:to_s()][self.direction:to_s()]
end

return Player

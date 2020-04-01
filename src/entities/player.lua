local Enum = require('src.enum')
local Sprite = require('src.sprite')

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
    up = Player.sprite:anim(0.1, '1-4', 1),
    down = Player.sprite:anim(0.1, '1-4', 2),
    right = Player.sprite:anim(0.1, '1-4', 3)
  },
  running = {
    up = Player.sprite:anim(0.1, '1-4', 4),
    down = Player.sprite:anim(0.1, '1-4', 5),
    right = Player.sprite:anim(0.1, '1-4', 6)
  }
}

Player.anims.iddle.left = Player.anims.iddle.right:clone():flipH()
Player.anims.running.left = Player.anims.running.right:clone():flipH()

Player.Collider = {}
Player.Collider.__index = Player.Collider

Player.Collider.w = 32
Player.Collider.h = 32
Player.Collider.offset = {x = 16, y = 32}

function Player.new(x, y)
  local self = setmetatable({}, Player)

  self.status = Status.iddle()
  self.direction = Direction.down()

  self.collider = setmetatable({}, self.Collider)
  self:move(x + self.collider.offset.x, y + self.collider.offset.y)

  return self
end

function Player:move(x, y)
  self.collider.x = x
  self.collider.y = y

  self.x = x - self.collider.offset.x
  self.y = y - self.collider.offset.y
end

function Player:anim()
  return self.anims[self.status:to_s()][self.direction:to_s()]
end

return Player

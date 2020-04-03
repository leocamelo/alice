local Enum = require('src.enum')
local Sprite = require('src.sprite')

local Status = Enum.new('iddle', 'running')
local Direction = Enum.new('up', 'down', 'left', 'right')

local Player = {}
Player.__index = Player

Player.is_player = true

Player.w = 64
Player.h = 64
Player.sprite = Sprite.new('player', Player.w, Player.h)

Player.speed = 300
Player.collider_w = 32
Player.collider_h = 32
Player.collider_offset = {x = 16, y = 32}

Player.card_offset = {x = 16, y = -74}

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

function Player.new(x, y)
  local self = setmetatable({}, Player)

  self.status = Status.iddle()
  self.direction = Direction.down()

  self.collider = {w = self.collider_w, h = self.collider_h}
  self:move(x + self.collider_offset.x, y + self.collider_offset.y)

  return self
end

function Player:update()
  self.x = self.collider.x - self.collider_offset.x
  self.y = self.collider.y - self.collider_offset.y

  if self.card then
    self.card.x = self.x + self.card_offset.x
    self.card.y = self.y + self.card_offset.y
  end
end

function Player:move(x, y)
  self.collider.x = x
  self.collider.y = y
  self:update()
end

function Player:set_card(card)
  self.card = card
  self:update()
end

function Player:anim()
  return self.anims[self.status:to_s()][self.direction:to_s()]
end

return Player

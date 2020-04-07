local Enum = require('src.enum')
local Class = require('src.class')
local Sprite = require('src.sprite')

local Suits = Enum.new('cup', 'pen', 'sword', 'wand')
local Faces = Enum.new('page', 'page', 'page', 'page')

local Card = Class.new()

Card.is_card = true
Card.is_ballon = true
Card.is_transient = true

Card.w = 34
Card.h = 58
Card.countdown_start = 1

Card.sprite = Sprite.new('card', Card.w, Card.h)

function Card:init(suit, number)
  self.suit = Suits:case(suit)
  self.face = Faces:case(Faces.options[number])

  self.countdown = self.countdown_start
  self.cached_quad = self.sprite:quad(self.suit.index, number)
end

function Card:cast(player)
  local spell = self.suit:to_s() .. '.' .. self.face:to_s()
  return require('src.entities.spells.' .. spell).new(player)
end

function Card:quad()
  return self.cached_quad
end

return Card

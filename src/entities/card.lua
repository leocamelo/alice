local Enum = require('src.enum')
local Sprite = require('src.sprite')

local Suits = Enum.new('cup', 'pen', 'sword', 'wand')

local Card = {}
Card.__index = Card

Card.is_card = true

Card.w = 34
Card.h = 58
Card.sprite = Sprite.new('card', Card.w, Card.h)

function Card.new(suit, number)
  local self = setmetatable({}, Card)

  self.suit = Suits.case(suit)
  self.number = number

  return self
end

function Card:draw()
  return self.sprite.grid:getFrames(self.suit.index, self.number)
end

return Card

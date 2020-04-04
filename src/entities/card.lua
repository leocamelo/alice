local Enum = require('src.enum')
local Sprite = require('src.sprite')

local Suits = Enum.new('cup', 'pen', 'sword', 'wand')

local Card = {}
Card.__index = Card

Card.is_card = true

Card.w = 34
Card.h = 58
Card.sprite = Sprite.new('card', Card.w, Card.h)

Card.spells = {
  sword = {
    require('src.entities.spells.sword_page')
  }
}

function Card.new(suit, number)
  local self = setmetatable({}, Card)

  self.suit = Suits:case(suit)
  self.number = number

  self.opacity = 1

  return self
end

function Card:cast(player)
  return self.spells[self.suit:to_s()][1].new(player)
end

function Card:quad()
  return self.sprite:quad(self.suit.index, self.number)
end

return Card

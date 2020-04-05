local tiny = require('vendor.tiny')
local Card = require('src.entities.card')

local system = tiny.processingSystem()

system.filter = tiny.requireAll('is_player')

function system:process(e, dt)
  if e.card then
    if e.card.countdown > 0 then
      e.card.opacity = math.min(e.card.countdown, 1)
    else
      e.card = nil
    end
  elseif love.keyboard.isDown('a') and e.status.is_iddle() then
    e:set_card(Card.new('sword', math.random(1, 4)))
    self.world:add(e.card)
    self.world:add(e.card:cast(e))
  end
end

return system

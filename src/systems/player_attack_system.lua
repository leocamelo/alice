local tiny = require('vendor.tiny')
local system = tiny.processingSystem()

local Card = require('src.entities.card')

system.filter = tiny.requireAll('is_player')

function system:process(e, dt)
  if e.card then
    if e.card.opacity > 0 then
      e.card.opacity = e.card.opacity - dt
    else
      self.world:remove(e.card)
      e.card = nil
    end
  elseif love.keyboard.isDown('a') and e.status.is_iddle() then
    e:set_card(Card.new('sword', math.random(1, 13)))
    self.world:add(e.card)
  end
end

return system

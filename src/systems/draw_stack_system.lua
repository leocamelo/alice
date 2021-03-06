local tiny = require('vendor.tiny')

local system = tiny.sortedProcessingSystem()

system.drawer = true
system.filter = tiny.requireAll('is_stack')

system.preProcess = system.onModify
system.onModify = nil

function system:compare(e1, e2)
  return e1.y + e1.h < e2.y + e2.h
end

function system:process(e)
  love.graphics.setColor(1, 1, 1)

  if e.anim then
    e:anim():draw(e.sprite.image, e.x, e.y)
  elseif e.quad then
    love.graphics.draw(e.sprite.image, e:quad(), e.x, e.y)
  elseif e.draw then
    e:draw()
  end
end

return system

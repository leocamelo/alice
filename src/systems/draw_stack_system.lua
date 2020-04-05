local tiny = require('vendor.tiny')

local system = tiny.sortedProcessingSystem()

system.drawer = true
system.filter = tiny.requireAll('is_stack')

function system:compare(e1, e2)
  return e1.y + e1.h < e2.y + e2.h
end

function system:preProcess()
  self:onModify()
  love.graphics.setColor(1, 1, 1)
end

function system:process(e)
  if e.anim then
    e:anim():draw(e.sprite.image, e.x, e.y)
  elseif e.quad then
    love.graphics.draw(e.sprite.image, e:quad(), e.x, e.y)
  else
    love.graphics.rectangle('fill', e.x, e.y, e.w, e.h)
  end
end

return system

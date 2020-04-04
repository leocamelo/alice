local tiny = require('vendor.tiny')
local system = tiny.processingSystem()

system.drawer = true
system.filter = tiny.requireAny('quad', 'is_spell')

function system:process(e)
  local quad = e.quad and e:quad()

  if quad then
    love.graphics.setColor(1, 1, 1, e.opacity or 1)
    love.graphics.draw(e.sprite.image, quad, e.x, e.y)
  else
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('fill', e.x, e.y, e.w, e.h)
  end
end

return system

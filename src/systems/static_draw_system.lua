local tiny = require('vendor.tiny')

local system = tiny.processingSystem()

system.drawer = true
system.filter = tiny.requireAny('quad', 'is_spell')

function system:process(e)
  local quad = e.quad and e:quad()
  love.graphics.setColor(1, 1, 1, e.opacity or 1)

  if quad then
    love.graphics.draw(e.sprite.image, quad, e.x, e.y)
  else
    love.graphics.rectangle('fill', e.x, e.y, e.w, e.h)
  end
end

return system

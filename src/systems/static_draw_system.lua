local tiny = require('vendor.tiny')
local system = tiny.processingSystem()

system.drawer = true
system.filter = tiny.requireAll('quad')

function system:process(e)
  local quad = e:quad()

  if quad then
    love.graphics.setColor(1, 1, 1, e.opacity or 1)
    love.graphics.draw(e.sprite.image, quad, e.x, e.y)
  end
end

return system

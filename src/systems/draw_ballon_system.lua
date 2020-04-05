local tiny = require('vendor.tiny')

local system = tiny.processingSystem()

system.drawer = true
system.filter = tiny.requireAll('is_ballon')

function system:process(e)
  love.graphics.setColor(1, 1, 1, e.opacity)
  love.graphics.draw(e.sprite.image, e:quad(), e.x, e.y)
end

return system

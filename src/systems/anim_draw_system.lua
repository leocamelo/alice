local tiny = require('vendor.tiny')
local system = tiny.processingSystem()

system.drawer = true
system.filter = tiny.requireAll('anim', 'sprite', 'x', 'y')

function system:process(e, dt)
  e:anim():draw(e.sprite.image, e.x, e.y)
end

return system

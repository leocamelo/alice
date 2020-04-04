local tiny = require('vendor.tiny')
local system = tiny.processingSystem()

system.drawer = true
system.filter = tiny.requireAll('anim')

function system:process(e)
  e:anim():draw(e.sprite.image, e.x, e.y)
end

return system

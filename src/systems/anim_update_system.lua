local tiny = require('vendor.tiny')
local system = tiny.processingSystem()

system.filter = tiny.requireAll('anim')

function system:process(e, dt)
  e:anim():update(dt)
end

return system

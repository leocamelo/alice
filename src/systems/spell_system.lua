local tiny = require('vendor.tiny')
local system = tiny.processingSystem()

system.filter = tiny.requireAll('is_spell')

function system:process(e, dt)
  e:update(self.physics, dt)
end

return system

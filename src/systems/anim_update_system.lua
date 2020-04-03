local tiny = require('vendor.tiny')
local system = tiny.processingSystem()

system.filter = tiny.requireAll('anim')

function system:process(e, dt)
  local anim = e:anim()

  if anim then
    anim:update(dt)
  end
end

return system

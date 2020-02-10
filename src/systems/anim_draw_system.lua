local tiny = require('vendor.tiny')
local system = tiny.processingSystem()

system.drawer = true
system.filter = tiny.requireAll('anim')

function system:process(e, dt)
  local anim = e:anim()

  if anim then
    anim:draw(e.sprite.image, e.x, e.y)
  end
end

return system

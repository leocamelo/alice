local tiny = require('vendor.tiny')

local system = tiny.processingSystem()

system.filter = tiny.requireAll('countdown')

function system:process(e, dt)
  if e.countdown > 0 then
    e.countdown = e.countdown - dt
  elseif e.is_transient then
    self.world:remove(e)
  end
end

return system

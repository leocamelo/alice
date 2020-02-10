local tiny = require('vendor.tiny')
local system = tiny.processingSystem()

system.filter = tiny.requireAll('is_attacking')

function system:process(e, dt)
  if love.keyboard.isDown('z') then
    if not e.is_attacking then
      e.is_attacking = true
    end
  elseif e.is_attacking then
    e.is_attacking = false
  end
end

return system

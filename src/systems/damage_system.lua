local tiny = require('vendor.tiny')

local system = tiny.processingSystem()

system.filter = tiny.requireAll('hp')

function system:process(e, dt)
  if e.damage then
    e.hp = math.max(e.hp - e.damage, 0)
    e.damage = nil
  end

  if e.hp == 0 then
    self.world:remove(e)
  end
end

return system

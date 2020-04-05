local tiny = require('vendor.tiny')
local Mob = require('src.entities.mob')

local system = tiny.system()

system.filter = tiny.requireAll('is_mob')

system.countdown_cicle = 2
system.mob_limit = 10

function system:onAddToWorld()
  self.countdown = self.countdown_cicle
end

function system:update(dt)
  if self.countdown > 0 then
    self.countdown = self.countdown - dt
  elseif #self.entities < self.mob_limit then
    local x = math.random(0, 800 - Mob.w)
    local y = math.random(0, 600 - Mob.h)

    local _, len = self.physics:queryRect(x, y, Mob.w, Mob.h)

    if len == 0 then
      self.world:add(Mob.new(x, y))
      self.countdown = self.countdown_cicle
    end
  end
end

return system

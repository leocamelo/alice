local tiny = require('vendor.tiny')
local Mob = require('src.entities.mob')

local system = tiny.system()

system.filter = tiny.requireAll('is_mob')

system.countdown_start = 2
system.mob_limit = 10

function system:onAddToWorld()
  local ww, wh = love.graphics.getDimensions()
  self.bonds = {w = ww - Mob.w, h = wh - Mob.h}

  self.countdown = self.countdown_start
end

function system:update(dt)
  if self.countdown > 0 then
    self.countdown = self.countdown - dt
  elseif #self.entities < self.mob_limit then
    local x = math.random(self.bonds.w)
    local y = math.random(self.bonds.h)

    local _, len = self.physics:queryRect(x, y, Mob.w, Mob.h)

    if len == 0 then
      self.world:add(Mob.new(x, y))
      self.countdown = self.countdown_start
    end
  end
end

return system

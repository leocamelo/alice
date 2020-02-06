local tiny = require('vendor.tiny')

local World = {}
World.__index = World

local updater_filter = tiny.rejectAll('drawer')
local drawer_filter = tiny.requireAll('drawer')

function World.new(...)
  local self = setmetatable({}, World)
  self.tiny = tiny.world(...)
  return self
end

function World:update(dt)
  self.tiny:update(dt, updater_filter)
end

function World:draw()
  self.tiny:update(0, drawer_filter)
end

return World

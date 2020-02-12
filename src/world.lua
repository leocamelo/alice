local tiny = require('vendor.tiny')
local bump = require('vendor.bump')

local World = {}
World.__index = World

World.cell_size = 32

local updater_filter = tiny.rejectAll('drawer')
local drawer_filter = tiny.requireAll('drawer')

function World.new(...)
  local self = setmetatable({}, World)

  self.tiny = tiny.world(...)
  self.bump = bump.newWorld(World.cell_size)

  for _, system in pairs(self.tiny.systems) do
    system.physics = self.bump
  end

  return self
end

function World:add(e)
  self.tiny:add(e)
  self.bump:add(e, e.x, e.y, e.w, e.h)
end

function World:update(dt)
  self.tiny:update(dt, updater_filter)
end

function World:draw()
  self.tiny:update(0, drawer_filter)
end

return World

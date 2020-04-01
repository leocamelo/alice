local tiny = require('vendor.tiny')
local bump = require('vendor.bump')

local updater_filter = tiny.rejectAll('drawer')
local drawer_filter = tiny.requireAll('drawer')

local World = {}
World.__index = World

World.cell_size = 64

function World.new(...)
  local self = setmetatable({}, World)

  self.tiny = tiny.world(...)
  self.bump = bump.newWorld(self.cell_size)

  for _, system in pairs(self.tiny.systems) do
    system.physics = self.bump
  end

  return self
end

function World:add(e)
  self.tiny:add(e)

  local c = e.collider
  if c then self.bump:add(c, c.x, c.y, c.w, c.h) end
end

function World:update(dt)
  self.tiny:update(dt, updater_filter)
end

function World:draw()
  self.tiny:update(0, drawer_filter)

  if os.getenv('DEBUG') then
    self:draw_colliders()
  end
end

function World:draw_colliders()
  for _, c in pairs(self.bump:getItems()) do
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle('line', c.x, c.y, c.w, c.h)
  end
end

return World

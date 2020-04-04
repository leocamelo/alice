local tiny = require('vendor.tiny')
local bump = require('vendor.bump')
local Class = require('src.class')

local World = Class.new()

World.cell_size = 64

local updater_filter = tiny.rejectAll('drawer')
local drawer_filter = tiny.requireAll('drawer')

function World:init(...)
  self.tiny = tiny.world(...)
  self.bump = bump.newWorld(self.cell_size)

  for _, system in pairs(self.tiny.systems) do
    system.world = self
    system.physics = self.bump
  end
end

function World:add(entity)
  self.tiny:add(entity)
  local c = entity.collider

  if c then
    self.bump:add(c, c.x, c.y, c.w, c.h)
  end
end

function World:remove(entity)
  self.tiny:remove(entity)
  local c = entity.collider

  if c and self.bump:hasItem(c) then
    self.bump:remove(c)
  end
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

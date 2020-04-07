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
    self:draw_debug()
  end
end

function World:draw_debug()
  love.graphics.setColor(1, 0, 0)
  love.graphics.setLineWidth(2)
  love.graphics.print('FPS: ' .. love.timer.getFPS( ), 16, 16)

  for _, e in ipairs(self.tiny.entities) do
    local c = e.collider

    if c then
      love.graphics.rectangle('line', c.x, c.y, c.w, c.h)
    end

    if e.hp then
      local label = string.format('HP: %02d/%02d', e.hp, e.max_hp)
      love.graphics.print(label, e.x + e.w, e.y)
    end
  end
end

return World

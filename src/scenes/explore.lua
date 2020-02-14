local Scene = require('src.scene')
local scene = Scene.new('explore')

local World = require('src.world')
local world

function scene:load()
  world = World.new(
    require('src.systems.anim_update_system'),
    require('src.systems.anim_draw_system'),
    require('src.systems.move_system'),
    require('src.systems.attack_system')
  )

  local Player = require('src.entities.player')
  world:add(Player.new(350, 350))
end

function scene:keypressed(key)
  if key == 'escape' then
    self:play('menu')
  end
end

function scene:update(dt)
  world:update(dt)
end

function scene:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.print('press esc to back', 50, 550)

  world:draw()
end

return scene

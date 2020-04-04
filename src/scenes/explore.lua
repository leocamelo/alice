local Scene = require('src.scene')
local scene = Scene.new('explore')

local World = require('src.world')
local world

local state = {
  x = 350,
  y = 350
}

function scene:load()
  world = World.new(
    require('src.systems.player_move_system'),
    require('src.systems.player_attack_system'),
    require('src.systems.spell_arrow_system'),
    require('src.systems.anim_update_system'),
    require('src.systems.anim_draw_system'),
    require('src.systems.static_draw_system')
  )

  local Enemy = require('src.entities.enemy')
  world:add(Enemy.new(100, 100))
  world:add(Enemy.new(500, 100))

  local Player = require('src.entities.player')
  world:add(Player.new(state.x, state.y))
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
  love.graphics.setBackgroundColor(0.3, 0.5, 0.3)

  love.graphics.setColor(1, 1, 1)
  love.graphics.print('press esc to back', 50, 550)

  world:draw()
end

return scene

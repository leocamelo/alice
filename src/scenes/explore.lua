local Scene = require('src.scene')
local World = require('src.world')

local scene = Scene.new('explore')
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
    require('src.systems.countdown_system'),
    require('src.systems.anim_update_system'),
    require('src.systems.draw_stack_system'),
    require('src.systems.draw_ballon_system')
  )

  local Mob = require('src.entities.mob')
  world:add(Mob.new(100, 100))
  world:add(Mob.new(500, 100))

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
  love.graphics.setBackgroundColor(0.4, 0.4, 0.5)
  world:draw()
end

return scene

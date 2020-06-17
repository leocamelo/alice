local Scene = require('src.scene')
local World = require('src.world')
local Joystick = require('src.joystick')
local screen = require('src.screen')

local scene = Scene.new('explore')
local world

function scene:load()
  math.randomseed(os.time())

  world = World.new(
    require('src.systems.player_move_system'),
    require('src.systems.player_attack_system'),
    require('src.systems.mob_spawn_system'),
    require('src.systems.mob_move_system'),
    require('src.systems.spell_arrow_system'),
    require('src.systems.damage_system'),
    require('src.systems.countdown_system'),
    require('src.systems.anim_update_system'),
    require('src.systems.draw_stack_system'),
    require('src.systems.draw_ballon_system')
  )

  local Player = require('src.entities.player')
  world:add(Player.new(Joystick.new(), screen:center(Player)))
end

function scene:keypressed(key)
  if key == 'escape' then
    self:play('menu')
  end
end

function scene:gamepadpressed(joystick, button)
  self:keypressed(Joystick.keymap[button])
end

function scene:update(dt)
  world:update(dt)
end

function scene:draw()
  love.graphics.setBackgroundColor(0.6, 0.6, 0.7)
  world:draw()
end

return scene

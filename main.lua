local Game = require('src.game')
local game

function love.load()
  love.joystick.loadGamepadMappings('vendor/gamecontrollerdb.txt')

  game = Game.new(
    require('src.scenes.menu'),
    require('src.scenes.explore')
  )
end

function love.keypressed(key)
  game:keypressed(key)
end

function love.gamepadpressed(joystick, button)
  game:gamepadpressed(joystick, button)
end

function love.update(dt)
  game:update(dt)
end

function love.draw()
  game:draw()
end

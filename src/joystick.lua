local Class = require('src.class')

local Joystick = Class.new()

Joystick.keymap = {
  start = 'escape',
  dpup = 'up',
  dpdown = 'down',
  dpleft = 'left',
  dpright = 'right',
  a = 'z',
  x = 'a'
}

local function is_gamepad_down(button)
  for _, joystick in ipairs(love.joystick.getJoysticks()) do
    if joystick:isGamepad() and joystick:isGamepadDown(button) then
      return true
    end
  end
  return false
end

function Joystick:init()
end

function Joystick:is_down(button)
  return is_gamepad_down(button) or love.keyboard.isDown(self.keymap[button])
end

return Joystick

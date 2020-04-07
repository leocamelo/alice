local Scene = require('src.scene')
local Observer = require('src.observer')

local scene = Scene.new('menu')
local observer = Observer.new()

local options
local selected

function scene:load()
  options = {
    {
      label = 'start',
      callback = function()
        self:play('explore')
      end
    },
    {
      label = 'quit',
      callback = love.event.quit
    }
  }

  observer:observe('up', function()
    selected = math.max(selected - 1, 1)
  end)

  observer:observe('down', function()
    selected = math.min(selected + 1, #options)
  end)

  observer:observe('z', function()
    options[selected].callback()
  end)
end

function scene:play()
  selected = 1
end

function scene:keypressed(key)
  observer:trigger(key)
end

function scene:draw()
  love.graphics.setBackgroundColor(0, 0, 0)

  for i, option in ipairs(options) do
    local color = i == selected and 1 or 0.5
    love.graphics.setColor(color, color, color)
    love.graphics.print(option.label, 400, 200 + i * 20)
  end
end

return scene

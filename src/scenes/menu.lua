local Scene = require('src.scene')
local scene = Scene.new('menu')

local Observer = require('src.observer')
local observer = Observer.new()

local options, selected

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
  love.graphics.print('*menu*', 350, 200)

  for i, option in ipairs(options) do
    local prefix = i == selected and '> ' or ''
    love.graphics.print(prefix .. option.label, 350, 200 + i * 20)
  end
end

return scene

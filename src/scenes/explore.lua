local Scene = require('src.scene')
local scene = Scene.new('explore')

function scene:update()
  if love.keyboard.isDown('escape') then
    self:play('menu')
  end
end

function scene:draw()
  love.graphics.print('*exploring*', 350, 200)
  love.graphics.print('press esc to back', 350, 220)
end

return scene

local Class = require('src.class')

local Game = Class.new()

function Game:init(initscene, ...)
  self.scenes = {}

  for _, scene in ipairs({initscene, ...}) do
    self.scenes[scene.id] = scene
  end

  self:play(initscene.id)
end

function Game:callback(key, ...)
  local callback = self.curscene[key]

  if callback then
    callback(self, ...)
  end
end

function Game:play(scene_id)
  self.curscene = self.scenes[scene_id]

  if not self.curscene.loaded then
    self:callback('load')
    self.curscene.loaded = true
  end

  self:callback('play')
end

function Game:keypressed(key)
  self:callback('keypressed', key)
end

function Game:update(dt)
  self:callback('update', dt)
end

function Game:draw()
  self:callback('draw')
end

return Game

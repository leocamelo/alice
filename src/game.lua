local Game = {}
Game.__index = Game

function Game.new(scenes)
  local self = setmetatable({}, Game)

  self.scenes = {}
  for _, scene in ipairs(scenes) do
    self.scenes[scene.id] = scene
  end

  self:play(scenes[1].id)
  return self
end

function Game:callback(key, ...)
  local callback = self.curscene[key]

  if callback then
    callback(self, ...)
  end
end

function Game:play(scene)
  self.curscene = self.scenes[scene]

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

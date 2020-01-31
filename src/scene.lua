local Scene = {}

function Scene.new(id)
  local self = {}

  self.id = id
  self.loaded = false

  return self
end

return Scene

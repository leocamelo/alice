local Class = require('src.class')

local Scene = Class.new()

function Scene:init(id)
  self.id = id
  self.loaded = false
end

return Scene

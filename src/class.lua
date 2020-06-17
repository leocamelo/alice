local Class = {}

function Class.new()
  local class = {}
  class.__index = class

  function class.new(...)
    local obj = setmetatable({}, class)
    obj:init(...)
    return obj
  end

  return class
end

return Class

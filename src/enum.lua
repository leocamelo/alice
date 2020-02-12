local Enum = {}
local EnumCase = {}
EnumCase.__index = EnumCase

function Enum.new(...)
  local self = {}
  local options = {...}

  for i, option in ipairs(options) do
    self[option] = function()
      return EnumCase.new(i, options)
    end
  end

  return self
end

function EnumCase.new(index, options)
  local self = setmetatable({}, EnumCase)

  self.index = index
  self.options = options

  for i, option in ipairs(options) do
    self[option] = function()
      self.index = i
    end
  end

  return self
end

function EnumCase:to_s()
  return self.options[self.index]
end

return Enum

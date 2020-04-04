local Enum = {}
Enum.__index = Enum

local EnumCase = {}
EnumCase.__index = EnumCase

function Enum.new(...)
  local self = setmetatable({}, Enum)

  self.options = {...}
  self.options_index = {}

  for i, option in ipairs(self.options) do
    self.options_index[option] = i

    self[option] = function()
      return EnumCase.new(i, self.options)
    end
  end

  return self
end

function Enum:case(option)
  local index = self.options_index[option]
  return EnumCase.new(index, self.options)
end

function EnumCase.new(index, options)
  local self = setmetatable({}, EnumCase)

  self.index = index
  self.options = options

  for i, option in ipairs(options) do
    self[option] = function()
      self.index = i
    end

    self['is_' .. option] = function()
      return self.index == i
    end
  end

  return self
end

function EnumCase:clone()
  return self.new(self.index, self.options)
end

function EnumCase:to_s()
  return self.options[self.index]
end

return Enum

local Enum = {}

function Enum.new(...)
  local self = {...}

  for i, alias in ipairs(self) do
    self[alias] = i
  end

  return self
end

return Enum

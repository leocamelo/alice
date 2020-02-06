local Observer = {}
Observer.__index = Observer

local callbacks_mt = {}

function callbacks_mt.__index(tab, key)
  if not rawget(tab, key) then
    rawset(tab, key, {})
  end

  return rawget(tab, key)
end

function Observer.new()
  local self = setmetatable({}, Observer)
  self.callbacks = setmetatable({}, callbacks_mt)
  return self
end

function Observer:observe(key, callback)
  local list = self.callbacks[key]
  list[#list + 1] = callback
end

function Observer:trigger(key, ...)
  for _, callback in ipairs(self.callbacks[key]) do
    callback(...)
  end
end

return Observer

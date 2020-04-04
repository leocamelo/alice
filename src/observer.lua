local Class = require('src.class')

local Observer = Class.new()
local callbacks_mt = {}

function callbacks_mt.__index(tab, key)
  local value = rawget(tab, key)

  if not value then
    value = {}
    rawset(tab, key, value)
  end

  return value
end

function Observer:init()
  self.callbacks = setmetatable({}, callbacks_mt)
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

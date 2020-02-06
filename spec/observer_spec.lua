local Observer = require('src.observer')

describe('Observer', function()
  describe('.new', function()
    it('assigns default callbacks', function()
      local observer = Observer.new()
      assert.are.same(observer.callbacks, {})
      assert.are.same(observer.callbacks.foo, {})
    end)
  end)

  describe(':observe', function()
  end)

  describe(':trigger', function()
  end)
end)

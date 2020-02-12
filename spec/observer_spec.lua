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
    it('adds callback to key', function()
      local observer = Observer.new()

      local callback = function() end
      observer:observe('foo', callback)

      assert.are.equals(#observer.callbacks.foo, 1)
      assert.are.equals(observer.callbacks.foo[1], callback)
    end)
  end)

  describe(':trigger', function()
    it('calls matched callbacks by key', function()
      local observer = Observer.new()

      local callback1 = spy.new(function() end)
      local callback2 = spy.new(function() end)
      observer:observe('foo', callback1)
      observer:observe('foo', callback2)
      observer:trigger('foo', 'bar')

      assert.spy(callback1).was.called_with('bar')
      assert.spy(callback2).was.called_with('bar')
    end)
  end)
end)

local Observer = require('src.observer')

describe('Observer', function()
  local observer

  before_each(function()
    observer = Observer.new()
  end)

  describe('.new', function()
    it('assigns default callbacks', function()
      assert.are.same(observer.callbacks, {})
      assert.are.same(observer.callbacks.foo, {})
    end)
  end)

  describe(':observe', function()
    it('adds callback to key', function()
      local callback = function() end
      observer:observe('foo', callback)

      assert.are.equals(#observer.callbacks.foo, 1)
      assert.are.equals(observer.callbacks.foo[1], callback)
    end)
  end)

  describe(':trigger', function()
    it('calls matched callbacks by key', function()
      local callback1 = spy.new()
      local callback2 = spy.new()
      observer:observe('foo', callback1)
      observer:observe('foo', callback2)
      observer:trigger('foo', 'bar')

      assert.spy(callback1).was.called_with('bar')
      assert.spy(callback2).was.called_with('bar')
    end)
  end)
end)

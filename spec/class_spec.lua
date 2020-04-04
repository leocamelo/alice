local Class = require('src.class')

describe('Class', function()
  local class = Class.new()

  describe('.new', function()
    it('returns a new class with constructor', function()
      assert.are.equals(type(class.new), 'function')
    end)

    it('calls class init callback on construct', function()
      class.init = spy.new()
      class.new()

      assert.spy(class.init).was.called()
    end)
  end)
end)

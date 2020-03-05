local Enum = require('src.enum')

describe('Enum', function()
  local enum

  before_each(function()
    enum = Enum.new('foo', 'bar')
  end)

  describe('.new', function()
    it('assign options as factories', function()
      assert.are.equals(type(enum.foo), 'function')
      assert.are.equals(type(enum.bar), 'function')
    end)
  end)

  describe(':option', function()
    local case

    before_each(function()
      case = enum.foo()
    end)

    it('returns a case with selected option', function()
      assert.are.equals(case.index, 1)
      assert.are.same(case.options, {'foo', 'bar'})
    end)

    it('assign options as setters', function()
      assert.are.equals(type(case.foo), 'function')
      assert.are.equals(type(case.bar), 'function')
    end)
  end)

  describe('Case:option', function()
    it('sets the selected option index', function()
      local case = enum.foo()
      assert.are.equals(case.index, 1)

      case.bar()
      assert.are.equals(case.index, 2)
    end)
  end)

  describe('Case:to_s', function()
    it('returns the current option as string', function()
      local case = enum.bar()
      assert.are.equals(case:to_s(), 'bar')
    end)
  end)
end)

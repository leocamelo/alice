local Scene = require('src.scene')

describe('Scene', function()
  describe('.new', function()
    it('assigns gived id', function()
      local scene = Scene.new('foo')
      assert.are.equals(scene.id, 'foo')
    end)

    it('assigns default loaded', function()
      local scene = Scene.new('bar')
      assert.is_false(scene.loaded)
    end)
  end)
end)
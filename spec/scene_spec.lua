local Scene = require('src.scene')

describe('Scene', function()
  local scene

  setup(function()
    scene = Scene.new('foo')
  end)

  describe('.new', function()
    it('assigns gived id', function()
      assert.are.equals(scene.id, 'foo')
    end)

    it('assigns default loaded', function()
      assert.is_false(scene.loaded)
    end)
  end)
end)

local Game = require('src.game')
local Scene = require('src.scene')

describe('Game', function()
  local scene1
  local scene2
  local game

  before_each(function()
    scene1 = Scene.new('foo')
    scene2 = Scene.new('bar')
    game = Game.new(scene1, scene2)
  end)

  describe('.new', function()
    it('assigns gived scenes as hash table', function()
      assert.are.equals(game.scenes.foo, scene1)
      assert.are.equals(game.scenes.bar, scene2)
    end)

    it('plays the first scene', function()
      assert.are.equals(game.curscene, scene1)
    end)
  end)

  describe(':callback', function()
    it('calls the current scene callback', function()
      spy.on(game.curscene, 'play')

      game:callback('play', 'baz')

      assert.spy(game.curscene.play).was.called_with(game, 'baz')
    end)
  end)

  describe(':play', function()
    it('turns the gived scene as current scene', function()
      game:play(scene2.id)

      assert.are.equals(game.curscene, scene2)
    end)

    it('calls the load and play callbacks when scene was unloaded', function()
      spy.on(scene2, 'load')
      spy.on(scene2, 'play')

      game:play(scene2.id)

      assert.spy(scene2.load).was.called()
      assert.spy(scene2.play).was.called()
    end)

    it('calls only the play callback when scene was loaded', function()
      spy.on(scene2, 'load')
      spy.on(scene2, 'play')

      scene2.loaded = true
      game:play(scene2.id)

      assert.spy(scene2.load).was_not.called()
      assert.spy(scene2.play).was.called()
    end)
  end)

  describe(':gamepadpressed', function()
    it('calls the gamepadpressed callback with gived arguments', function()
      spy.on(game, 'callback')

      game:gamepadpressed(1, 'a')

      assert.spy(game.callback).was.called_with(game, 'gamepadpressed', 1, 'a')
    end)
  end)

  describe(':keypressed', function()
    it('calls the keypressed callback with gived key', function()
      spy.on(game, 'callback')

      game:keypressed('up')

      assert.spy(game.callback).was.called_with(game, 'keypressed', 'up')
    end)
  end)

  describe(':update', function()
    it('calls the update callback with gived dt', function()
      spy.on(game, 'callback')

      game:update(1)

      assert.spy(game.callback).was.called_with(game, 'update', 1)
    end)
  end)

  describe(':draw', function()
    it('calls the draw callback', function()
      spy.on(game, 'callback')

      game:draw()

      assert.spy(game.callback).was.called_with(game, 'draw')
    end)
  end)
end)

package xtremeengine;

import xtremeengine.errors.Error;

/**
 * Default implementation of the IGameObject interface.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class GameObject implements IGameObject {
    private var _game:IGame;

    /**
     * Constructor.
     *
     * @param game
     *      The game to which the object belongs.
     */
    public function new(game:IGame):Void
    {
        if (game == null) { throw new Error("Null Game."); }
        _game = game;
    }

    /**
	 * The game to which the object belongs.
	 */
	public var game(get, never):IGame;
    private inline function get_game():IGame { return _game; }
}
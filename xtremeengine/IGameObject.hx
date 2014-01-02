package xtremeengine;

import xtremeengine.IGame;

/**
 * Interface which defines objects that have a reference to an IGame.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IGameObject {
	/**
	 * The game to which the object belongs.
	 */
	public var game(get, never):IGame;
}
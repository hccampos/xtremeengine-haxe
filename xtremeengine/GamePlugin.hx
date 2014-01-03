package xtremeengine;

import promhx.Promise;
import xtremeengine.utils.Utils;

/**
 * Abstract class which implements the common members of the IGamePlugin interface. Subclasses
 * should override the initialize() and destroy() methods.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class GamePlugin extends GameObject implements IGamePlugin {
	private var _name:String;
    private var _isInitialized:Bool;
	
	/**
	 * Initializes the instance.
	 *
	 * @param game
	 * 		The game to which the plugin belongs.
	 * @param name
	 * 		The name of the new plugin.
	 */
	public function new(game:IGame, name:String):Void {
		super(game);

		_name = name;
        _isInitialized = false;
	}
	
	/**
	 * Initializes the plugin.
     *
     * @return A promise which is resolved when the plugin has been initialized.
	 */
	public function initialize():Void {
        _isInitialized = true;
    }
	
	/**
	 * Called before the plugin is removed from the game or when the game is about to be destroyed.
     * The plugin should destroy any resources it may have created.
     *
     * @return A promise which is resolved when the plugin has been destroyed.
	 */
	public function destroy():Void {
        _isInitialized = false;
    }
	
	/**
	 * The name of the plugin.
	 */
	public var name(get, never):String;
	private inline function get_name():String { return _name; }

    /**
     * Whether the plugin has been initialized.
     */
    public var isInitialized(get, never):Bool;
    private inline function get_isInitialized():Bool { return _isInitialized; }
}
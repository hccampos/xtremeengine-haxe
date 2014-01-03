package xtremeengine;

import promhx.Promise;
import xtremeengine.utils.Utils;

/**
 * Abstract class which implements the common members of the ICorePlugin interface. Subclasses
 * should override the initialize() and destroy() methods.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class CorePlugin extends CoreObject implements ICorePlugin {
	private var _name:String;
    private var _isInitialized:Bool;
	
	/**
	 * Initializes the instance.
	 *
	 * @param core
	 * 		The core object to which the plugin belongs.
	 * @param name
	 * 		The name of the new plugin.
	 */
	public function new(core:ICore, name:String):Void {
		super(core);

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
	 * Called before the plugin is removed from the core object or when the core object is about to
	 * be destroyed. The plugin should destroy any resources it may have created.
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
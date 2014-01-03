package xtremeengine.input;

import xtremeengine.input.IInputManager;
import xtremeengine.CorePlugin;

/**
 * Default implementation of the IInputManager interface.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class InputManager extends CorePlugin implements IInputManager {
    private var _keyboard:IKeyboard;
    private var _currentKeyboardState:IKeyboardState;
    private var _previousKeyboardState:IKeyboardState;
    private var _isEnabled:Bool;
    private var _updateOrder:Int;

    //--------------------------------------------------------------------------------------------//

    /**
     * Constructor.
     *
     * @param core
     *      The core to which the input manager belongs.
     * @param name
     *      The name of the input manager.
     */
    public function new(core:ICore, name:String)
    {
        super(core, name);

        _isEnabled = true;
        _updateOrder = 0;
    }

    //--------------------------------------------------------------------------------------------//
    //{ Public Methods
    //--------------------------------------------------------------------------------------------//

    /**
     * Initializes the input manager.
     */
    public override function initialize():Void {
        if (this.isInitialized) { return; }

        _keyboard = new Keyboard(this);
        _currentKeyboardState = _keyboard.getState();
        _previousKeyboardState = _keyboard.getState();

        super.initialize();
    }

    /**
     * Destroys the input manager.
     */
    public override function destroy():Void {
        if (!this.isInitialized) { return; }

        _currentKeyboardState = null;
        _previousKeyboardState = null;

        super.destroy();
    }

    /**
	 * Updates the GUI.
	 *
	 * @param elapsedTime
	 * 		The number of milliseconds elapsed since the last update.
	 */
	public function update(elapsedMillis:Float):Void {
        // Take a snapshot of the keyboard state.
        _previousKeyboardState = _currentKeyboardState;
        _currentKeyboardState = _keyboard.getState();
    }

    /**
     * Gets whether the specified key is up.
     *
     * @param key
     *      The key whose state is to be checked.
     *
     * @return True if the key is up and false otherwise.
     */
    public function isKeyUp(key:Int):Bool {
        return _currentKeyboardState.isKeyUp(key);
    }

    /**
     * Gets whether the specified key is down/pressed.
     *
     * @param key
     *      The key whose state is to be checked.
     *
     * @return True if the key is down and false otherwise.
     */
    public function isKeyDown(key:Int):Bool {
        return _currentKeyboardState.isKeyDown(key);
    }

    /**
     * Gets whether the specified key has just been pressed (as opposed to having been down for a
     * while).
     *
     * @param key
     *      The key whose state is to be checked.
     *
     * @return True if the key has just been pressed and false otherwise.
     */
    public function isNewKeyDown(key:Int):Bool {
        return _currentKeyboardState.isKeyDown(key) && _previousKeyboardState.isKeyUp(key);
    }

    //}
    //--------------------------------------------------------------------------------------------//

    //--------------------------------------------------------------------------------------------//
    //{ Properties
    //--------------------------------------------------------------------------------------------//

    /**
	 * Whether the input manager is enabled.
	 */
	public var isEnabled(get, set):Bool;
    private inline function get_isEnabled():Bool { return _isEnabled; }
    private inline function set_isEnabled(value:Bool):Bool { return _isEnabled = value; }
	
	/**
	 * Value used to sort objects before updating.
	 */
	public var updateOrder(get, set):Int;
    private inline function get_updateOrder():Int { return _updateOrder; }
    private inline function set_updateOrder(value:Int):Int { return _updateOrder = value; }

    //}
    //--------------------------------------------------------------------------------------------//
}
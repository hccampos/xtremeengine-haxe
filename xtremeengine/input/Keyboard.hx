package xtremeengine.input;

import flash.events.KeyboardEvent;
import xtremeengine.Context;
import xtremeengine.input.IKeyboard;

/**
 * Default implementation of the IKeyboard interface.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class Keyboard implements IKeyboard {
    private var _inputManager:IInputManager;
    private var _state:KeyboardState;
    private var _isInitialized:Bool;

    //--------------------------------------------------------------------------------------------//

    /**
     * Constructor.
     *
     * @param inputManager
     *      The input manager to which the keyboard belongs.
     */
    public function new(inputManager:IInputManager):Void
    {
        _inputManager = inputManager;
        _isInitialized = false;
    }

    //--------------------------------------------------------------------------------------------//
    //{ Public Methods
    //--------------------------------------------------------------------------------------------//

    /**
	 * Initializes the object.
	 */
	public function initialize():Void {
        if (_isInitialized) { return; }

        _state = new KeyboardState();

        var context:Context = _inputManager.core.context;
        if (context != null && context.stage != null) {
            context.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);
            context.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp, false, 0, true);
        }

        _isInitialized = true;
    }
	
	/**
	 * Called before the object is destroyed.
	 */
	public function destroy():Void {
        if (!_isInitialized) { return; }

        _state = null;

        var context:Context = _inputManager.core.context;
        if (context != null && context.stage != null) {
            context.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false);
            context.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp, false);
        }

        _isInitialized = false;
    }

    /**
     * Gets the current state of the keyboard.
     */
    private inline function getState():IKeyboardState { return _state.clone(); }

    //}
    //--------------------------------------------------------------------------------------------//

    //--------------------------------------------------------------------------------------------//
    //{ Properties
    //--------------------------------------------------------------------------------------------//

    /**
     * Whether the object is initialized.
     */
    public var isInitialized(get, never):Bool;
    private inline function get_isInitialized():Bool { return _isInitialized; }

    //}
    //--------------------------------------------------------------------------------------------//

    //--------------------------------------------------------------------------------------------//
    //{ Private Methods
    //--------------------------------------------------------------------------------------------//

    /**
     * Called when a key is pressed.
     *
     * @param event
     *      The object which contains the event information.
     */
    private function onKeyDown(event:KeyboardEvent):Void {
        _state.down(event.keyCode);
    }

    /**
     * Called when a key is released.
     *
     * @param event
     *      The object which contains the event information.
     */
    private function onKeyUp(event:KeyboardEvent):Void {
        _state.up(event.keyCode);
    }

    //}
    //--------------------------------------------------------------------------------------------//
}
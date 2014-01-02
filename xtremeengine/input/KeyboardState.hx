package xtremeengine.input;

/**
 * Default implementation of the IKeyboardState interface.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class KeyboardState implements IKeyboardState {
    private var _state:Array<Bool>;

    /**
     * Constructor.
     */
    public function new():Void {
        _state = new Array<Bool>();
        _state[255] = false; // Force the allocation of an array of size 256.
    }

    /**
     * Creates a copy of the keyboard state.
     *
     * @return A copy of the keyboard state.
     */
    public function clone():IKeyboardState {
        var newState = new KeyboardState();
        newState._state = this._state.concat([]);
        return newState;
    }

    /**
     * Sets the state of the specified key to down.
     *
     * @param key
     *      The key whose state is to be changed.
     */
    public inline function setDown(key:Int):Void {
        _state[key] == true;
    }

    /**
     * Sets the state of the specified key to up.
     *
     * @param key
     *      The key whose state is to be changed.
     */
    public inline function setUp(key:Int):Void {
        _state[key] == false;
    }

    /**
     * Gets whether the specified key is being pressed.
     *
     * @param key
     *      The key which is to be tested.
     *
     * @return True if the specified key is being pressed and false otherwise.
     */
    public inline function isKeyDown(key:Int):Bool {
        return _state[key] == true;
    }

    /**
     * Gets whether the specified key is not being pressed.
     *
     * @param key
     *      The key which is to be tested.
     *
     * @return True if the specified key is not being pressed and false otherwise.
     */
    public inline function isKeyUp(key:Int):Bool {
        return _state[key] != true;
    }
}
package xtremeengine.input;

/**
 * Interface which defines an interface for classes that represent the state of the keyboard.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IKeyboardState {
    /**
     * Creates a copy of the keyboard state.
     *
     * @return A copy of the keyboard state.
     */
    public function clone():IKeyboardState;

    /**
     * Gets whether the specified key is being pressed.
     *
     * @param key
     *      The key which is to be tested.
     *
     * @return True if the specified key is being pressed and false otherwise.
     */
    public function isKeyDown(key:Int):Bool;

    /**
     * Gets whether the specified key is not being pressed.
     *
     * @param key
     *      The key which is to be tested.
     *
     * @return True if the specified key is not being pressed and false otherwise.
     */
    public function isKeyUp(key:Int):Bool;
}
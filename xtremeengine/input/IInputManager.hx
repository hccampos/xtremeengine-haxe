package xtremeengine.input;

/**
 * Interface which defines an InputManager plugin. An input manager is responsible for keeping track
 * and giving access to user input through various input devices.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IInputManager extends IPlugin extends IUpdateable {
    /**
     * Gets whether the specified key is up.
     *
     * @param key
     *      The key whose state is to be checked.
     *
     * @return True if the key is up and false otherwise.
     */
    public function isKeyUp(key:Int):Bool;

    /**
     * Gets whether the specified key is down/pressed.
     *
     * @param key
     *      The key whose state is to be checked.
     *
     * @return True if the key is down and false otherwise.
     */
    public function isKeyDown(key:Int):Bool;

    /**
     * Gets whether the specified key has just been pressed (as opposed to having been down for a
     * while).
     *
     * @param key
     *      The key whose state is to be checked.
     *
     * @return True if the key has just been pressed and false otherwise.
     */
    public function isNewKeyDown(key:Int):Bool;
}
package xtremeengine.input;

import xtremeengine.Context;
import xtremeengine.IInitializable;

/**
 * Interface which must be implemented by a Keyboard.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IKeyboard extends IInitializable {
    /**
     * Gets the current state of the keyboard.
     */
    public function getState():IKeyboardState;
}
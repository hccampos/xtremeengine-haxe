package xtremeengine.screens;

import xtremeengine.Context;
import xtremeengine.IInitializable;
import xtremeengine.ILoadable;
import xtremeengine.INamed;
import xtremeengine.IUpdateable;

/**
 * The screen manager is a component which manages one or more game screens. It maintains a stack of
 * screens, updates them at the appropriate times, and automatically routes input to the topmost
 * active screen.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IScreenManager extends IInitializable extends IUpdateable extends ILoadable extends IScreenCollection {
    /**
     * The context to which the screens are added.
     */
    public var context(get, never):Context;
}
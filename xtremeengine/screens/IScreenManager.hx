package xtremeengine.screens;

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
interface IScreenManager extends IInitializable
                         extends IUpdateable
                         extends ILoadable
                         extends IScreenCollection
{
}
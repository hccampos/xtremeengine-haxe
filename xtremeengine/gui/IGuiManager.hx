package xtremeengine.gui;

import xtremeengine.Context;
import xtremeengine.IPlugin;
import xtremeengine.IUpdateable;

/**
 * Interface which must be implemented by all the gui manager.
 *
 * A GUI manager is responsible for managing and updating the various GUI elements.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IGuiManager extends IPlugin extends IUpdateable {
    /**
	 * The context where the GUI elements are to be displayed.
	 */
    public var context(get, never):Context;
}
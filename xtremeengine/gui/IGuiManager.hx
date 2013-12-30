package xtremeengine.gui;

import xtremeengine.IPlugin;
import xtremeengine.IUpdateable;
import flash.display.DisplayObjectContainer;

/**
 * Interface which must be implemented by all the gui manager.
 *
 * A GUI manager is responsible for managing and updating the various GUI elements.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IGuiManager extends IPlugin extends IUpdateable {
    /**
	 * The display object container which contains the GUI elements.
	 */
    public var guiContainer(get, never):DisplayObjectContainer;
}
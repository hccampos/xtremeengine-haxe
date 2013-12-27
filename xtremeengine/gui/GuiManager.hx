package xtremeengine.gui;

import xtremeengine.ICore;
import xtremeengine.APlugin;
import flash.display.DisplayObjectContainer;
import flash.Lib;

/**
 * Default implementation of the IGuiManager interface.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class GuiManager extends APlugin implements IGuiManager
{
    private var _guiContainer:DisplayObjectContainer;
    private var _isEnabled:Bool;
    private var _updateOrder:Int;

    //--------------------------------------------------------------------------------------------//

    /**
     * Initializes a new gui manager.
     *
     * @param core
     *      The core object to which the manager belongs.
     * @param name
     *      The name of the manager.
     */
    public function new(core:ICore, name:String):Void
    {
        super(core, name);

        _isEnabled = true;
        _updateOrder = 0;
    }

    //--------------------------------------------------------------------------------------------//
    //{ Public Methods
    //--------------------------------------------------------------------------------------------//

    /**
	 * Initializes the GUI manager.
	 */
	public override function initialize():Void
	{
        super.initialize();

		_guiContainer = new DisplayObjectContainer();
		Lib.current.stage.addChild(_guiContainer);
	}

    /**
	 * Destroys the GUI manager and any resources aquired by it.
	 */
	public override function destroy():Void
	{
		Lib.current.stage.removeChild(_guiContainer);
        _guiContainer = null;

        super.destroy();
	}

    /**
	 * Updates the GUI.
	 *
	 * @param elapsedTime
	 * 		The number of milliseconds elapsed since the last update.
	 */
	public function update(elapsedMillis:Float):Void
	{
	}

    //}
    //--------------------------------------------------------------------------------------------//


    //--------------------------------------------------------------------------------------------//
    //{ Properties
    //--------------------------------------------------------------------------------------------//

    /**
	 * The display object container which contains the GUI elements.
	 */
    public var guiContainer(get, never):DisplayObjectContainer;
    private inline function get_guiContainer():DisplayObjectContainer { return _guiContainer; }

    /**
	 * Whether the object is enabled.
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
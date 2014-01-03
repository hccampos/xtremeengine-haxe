package xtremeengine.gui;

import xtremeengine.Context;
import xtremeengine.ICore;
import xtremeengine.CorePlugin;
import flash.display.DisplayObjectContainer;

/**
 * Default implementation of the IGuiManager interface.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class GuiManager extends CorePlugin implements IGuiManager {
    private var _context:Context;
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
    public function new(core:ICore, name:String):Void {
        super(core, name);

        _context = new Context();
        _isEnabled = true;
        _updateOrder = 0;
    }

    //--------------------------------------------------------------------------------------------//
    //{ Public Methods
    //--------------------------------------------------------------------------------------------//

    /**
	 * Initializes the GUI manager.
	 */
	public override function initialize():Void {
        this.core.context.addChild(this.context);

        super.initialize();
	}

    /**
	 * Destroys the GUI manager and any resources aquired by it.
	 */
	public override function destroy():Void {
        this.core.context.removeChild(this.context);

        super.destroy();
	}

    /**
	 * Updates the GUI.
	 *
	 * @param elapsedTime
	 * 		The number of milliseconds elapsed since the last update.
	 */
	public function update(elapsedMillis:Float):Void {}

    //}
    //--------------------------------------------------------------------------------------------//


    //--------------------------------------------------------------------------------------------//
    //{ Properties
    //--------------------------------------------------------------------------------------------//

    /**
	 * The context where the GUI elements are to be displayed.
	 */
    public var context(get, never):Context;
    private inline function get_context():Context { return _context; }

    /**
	 * Whether the GUI manager is enabled.
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
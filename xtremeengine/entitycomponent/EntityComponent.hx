package xtremeengine.entitycomponent;

import xtremeengine.CoreObject;
import xtremeengine.ICore;

/**
 * ...
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class EntityComponent extends CoreObject implements IEntityComponent
{
    private var _name:String;
    private var _owner:IEntity;
    private var _isEnabled:Bool;
    private var _updateOrder:Bool;

    /**
     * Initializes a new component.
     *
     * @param core
     *      The core object to which the component belongs.
     * @param name
     *      The name of the component.
     */
    public function new(core:ICore, name:String):Void
    {
        super(core);

        _name = name;
        _owner = null;
        _isEnabled = true;
        _updateOrder = 0;
    }

    /**
	 * Called when the component is added to an entity.
	 */
	public function onAdd():Void
    {

    }
	
	/**
	 * Called when another component is added or removed from the entity. This method should be used
	 * by the component to aquire or release references to other components in the entity.
	 */
	public function onReset():Void
    {

    }
	
	/**
	 * Called when the component is removed from an entity.
	 */
	public function onRemove():Void
    {

    }

    /**
	 * Updates the component.
	 *
	 * @param elapsedTime
	 * 		The number of milliseconds elapsed since the last update.
	 */
	public function update(elapsedMillis:Float):Void
    {
    }

    /**
     * The name of the component.
     */
    public var name(get, never):String;
    private inline function get_name():String { return _name; }
	
    /**
	 * Whether the component is enabled.
	 */
	public var isEnabled(get, set):Bool;
    private inline function get_isEnabled():Bool { return _isEnabled; }
    private inline function set_isEnabled(value:Bool):Bool { return _isEnabled = value; }
	
	/**
	 * The update order of the component.
	 */
	public var updateOrder(get, set):Int;
    private inline function get_updateOrder():Int { return _updateOrder; }
    private inline function set_updateOrder(value:Int):Int { return _updateOrder = value; }

    /**
	 * The entity who owns the components (i.e. the entity to which the component has been added).
	 */
	public var owner(get, set):IEntity;
    private inline function get_owner():IEntity { return _owner; }
    private inline function set_owner(value:IEntity):IEntity { return _owner = value; }
}
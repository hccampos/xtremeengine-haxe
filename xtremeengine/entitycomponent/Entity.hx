package xtremeengine.entitycomponent;

import xtremeengine.CoreObject;
import xtremeengine.errors.Error;
import xtremeengine.ICore;

/**
 * Default implementation of the IEntity interface.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class Entity extends CoreObject implements IEntity {
	private var _name:String;
	private var _components:Array<IEntityComponent>;
	private var _isEnabled:Bool;
	private var _updateOrder:Int;
	
    //--------------------------------------------------------------------------------------------//

	/**
	 * Initializes a new Entity.
     *
	 * @param core
     *      The core object to which the entity belongs.
	 * @param name
     *      The name of the new entity.
	 */
	public function new(core:ICore, name:String) {
		super(core);
		_name = name;
		_components = new Array<IEntityComponent>();
		_isEnabled = true;
		_updateOrder = 0;
	}
	
    //--------------------------------------------------------------------------------------------//
    //{ Public Methods
    //--------------------------------------------------------------------------------------------//

	/**
	 * Updates the state of the object.
	 *
	 * @param elapsedTime
	 * 		The number of milliseconds elapsed since the last update.
	 */
	public function update(elapsedMillis:Float):Void {
		for (component in _components) {
			if (component.isEnabled) { component.update(elapsedMillis); }
		}
	}
	
	/**
	 * Adds a component to the entity.
	 *
	 * @param component
	 * 		The component which is to be added.
	 */
	public function addComponent(component:IEntityComponent):Void {
		if (component == null) { throw new Error("Trying to add a null entity component."); }
		if (this.hasComponent(component)) {
			throw new Error("Trying to add a component that has already been added to the entity.");
		}
		
		component.owner = this;
		_components.push(component);
		
		component.onAdd();
		resetComponents();
	}
	
	/**
	 * Removes the specified component from the entity.
	 *
	 * @param component
	 * 		The component which is to be removed.
	 *
	 * @return True if the component was removed and false otherwise.
	 */
	public function removeComponent(component:IEntityComponent):Bool {
        if (component == null) { return false; }

		if (_components.remove(component)) {
			component.owner = null;
			component.onRemove();
			resetComponents();
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * Removes the component which is identified by the specified name from the entity.
	 *
	 * @param name
	 * 		The name of the component which is to be removed.
	 *
	 * @return True if the component was removed and false otherwise.
	 */
	public function removeComponentByName(name:String):Bool {
        return this.removeComponent(this.getComponentByName(name));
	}
	
	/**
	 * Removes all the components of the entity.
	 */
	public function removeAllComponents():Void {
		var toRemove:Array<IEntityComponent> = _components.concat([]);
		for (component in toRemove) {
			this.removeComponent(component);
		}
	}
	
    /**
	 * Gets the component which has the specified name.
     *
     * @param name
     *      The name of the component which is to be retrieved.
	 */
	public function getComponentByName(name:String):IEntityComponent {
        if (name == null || name == "") { return null; }

        for (component in _components) {
            if (component.name == name) { return component; }
        }
		
		return null;
	}

	/**
	 * Gets the first component of the specified type that is found.
     *
     * @param cls
     *      The type of component that is to be retrieved.
	 */
	public function getComponentByType<T: IEntityComponent>(cls:Class<T>):T {

        for (component in _components) {
            if (Std.is(component, cls)) {
                var ret:T = cast component;
                return ret;
            }
        }
		
		return null;
	}
	
	/**
	 * Gets an array with all the components of the specified type.
     *
     * @param cls
     *      The type of the components which are to be retrieved.
	 */
	public function getComponentsByType<T: IEntityComponent>(cls:Class<T>):Array<T> {
		var foundComponents:Array<T> = new Array<T>();
		
		for (component in _components) {
			if (Std.is(component, cls)) {
				var foundComponent:T = cast component;
				foundComponents.push(foundComponent);
			}
		}
		
		return foundComponents;
	}
	
    /**
     * Gets whether the entity has the specified component.
     *
     * @param component
     *      The component which is to be found.
     *
     * @return True if the entity has the component and false otherwise.
     */
    public function hasComponent(component:IEntityComponent):Bool {
        return Lambda.has(_components, component);
    }

    /**
     * Gets whether the entity has a component with the specified name.
     *
     * @param name
     *      The name of the component which is to be found.
     *
     * @return True if the entity has the component and false otherwise.
     */
    public function hasComponentNamed(name:String):Bool {
        return this.getComponentByName(name) != null;
    }

	/**
	 * Calls the onReset() method on all the components of the entity.
	 */
	public function resetComponents():Void {
		for (component in _components) {
			component.onReset();
		}
	}

    //}
    //--------------------------------------------------------------------------------------------//
	
    //--------------------------------------------------------------------------------------------//
    //{ Properties
    //--------------------------------------------------------------------------------------------//

	/**
	 * The name of the entity.
	 */
	public var name(get, never):String;
	private inline function get_name():String { return _name; }
	
	/**
	 * Whether the entity is enabled.
	 */
	public var isEnabled(get, set):Bool;
	private inline function get_isEnabled():Bool { return _isEnabled; }
	private inline function set_isEnabled(value:Bool):Bool { return _isEnabled = value; }
	
	/**
	 * Value which indicates the order in which the entity is to be updated.
	 */
	public var updateOrder(get, set):Int;
	private inline function get_updateOrder():Int { return _updateOrder; }
	private inline function set_updateOrder(value:Int):Int { return _updateOrder = value; }

    //}
    //--------------------------------------------------------------------------------------------//
}
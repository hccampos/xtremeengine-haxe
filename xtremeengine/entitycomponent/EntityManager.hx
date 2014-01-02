package xtremeengine.entitycomponent;

import xtremeengine.errors.Error;
import xtremeengine.ICore;
import xtremeengine.Plugin;

/**
 * Default implementation of the IEntityManager interface.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class EntityManager extends Plugin implements IEntityManager {
    private var _entities:Array<IEntity>;
    private var _isEnabled:Bool;
    private var _updateOrder:Int;

    //--------------------------------------------------------------------------------------------//

    /**
     * Initializes a new entity manager.
     *
     * @param core
     *      The core object to which the entity manager belongs.
     * @param name
     *      The name of the entity manager.
     */
    public function new(core:ICore, name:String):Void {
        super(core, name);
        _entities = new Array<IEntity>();
        _isEnabled = true;
        _updateOrder = 0;
    }

    //--------------------------------------------------------------------------------------------//
    //{ Public Methods
    //--------------------------------------------------------------------------------------------//

	/**
	 * Called before the plugin is removed from the core object or when the core object is about to
	 * be destroyed. The plugin should destroy any resources it may have created.
	 */
	public override function destroy():Void {
        for (entity in _entities) {
            entity.removeAllComponents();
        }

        _entities = null;

        super.destroy();
    }

    /**
	 * Updates all the entities managed by the entity manager.
	 *
	 * @param elapsedTime
	 * 		The number of milliseconds elapsed since the last update.
	 */
	public function update(elapsedMillis:Float):Void {
        for (entity in _entities) {
            if (entity.isEnabled) { entity.update(elapsedMillis); }
        }
    }

    /**
	 * Adds the specified entity to the manager.
	 *
	 * @param entity
	 * 		The entity which is to be added.
	 */
	public function addEntity(entity:IEntity):Void {
        if (entity == null) { throw new Error("Trying to add a null entity."); }
        if (this.hasEntity(entity)) {
			throw new Error("Trying to add an entity that has already been added to the entity manager.");
		}

        entity.owner = this;
        _entities.push(entity);

        entity.onAdd();
    }
	
	/**
	 * Removes the specified entity from the manager.
	 *
	 * @param entity
	 * 		The entity which is to be removed.
	 *
	 * @return True if the entity was removed and false otherwise.
	 */
	public function removeEntity(entity:IEntity):Bool {
        if (entity == null) { return false; }

        if (_entities.remove(entity)) {
            entity.onRemove();
            entity.owner = null;
            return true;
        } else {
            return false;
        }
    }
	
	/**
	 * Removes the entity which is identified by the specified name from the manager.
	 *
	 * @param name
	 * 		The name of the entity which is to be removed.
	 *
	 * @return True if the entity was removed and false otherwise.
	 */
	public function removeEntityByName(name:String):Bool {
        return this.removeEntity(this.getEntityByName(name));
    }
	
    /**
	 * Removes all the entities from the manager.
	 */
	public function removeAllEntities():Void {
        var toRemove:Array<IEntity> = _entities.concat([]);
        for (entity in toRemove) {
            this.removeEntity(entity);
        }
    }

	/**
	 * Gets the entity which is identified by the specified name.
	 *
	 * @param name
	 * 		The name of the entity which is to be retrieved.
	 *
	 * @return The entity which is identified by the specified name.
	 */
	public function getEntityByName(name:String):IEntity {
        if (name == null || name == "") { return null; }

        for (entity in _entities) {
            if (entity.name == name) { return entity; }
        }

        return null;
    }

    /**
	 * Gets whether the manager has the specified entity.
	 *
	 * @param entity
	 * 		The entity which is to be found.
	 *
	 * @return True if the manager has the specified entity and false otherwise.
	 */
	public function hasEntity(entity:IEntity):Bool {
        return Lambda.has(_entities, entity);
    }

    /**
	 * Gets whether the manager has the specified entity.
	 *
	 * @param name
	 * 		The name of the entity which is to be found.
	 *
	 * @return True if the manager has the specified entity and false otherwise.
	 */
	public function hasEntityNamed(name:String):Bool {
        return this.getEntityByName(name) != null;
    }
	
    //}
    //--------------------------------------------------------------------------------------------//

    //--------------------------------------------------------------------------------------------//
    //{ Properties
    //--------------------------------------------------------------------------------------------//

	/**
	 * The entities managed by the entity manager.
	 */
	public var entities(get, never):Array<IEntity>;
    private inline function get_entities():Array<IEntity> { return _entities; }

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
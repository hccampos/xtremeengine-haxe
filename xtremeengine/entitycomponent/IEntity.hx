package xtremeengine.entitycomponent;

import xtremeengine.ICore;
import xtremeengine.ICoreObject;
import xtremeengine.INamed;
import xtremeengine.IUpdateable;

/**
 * Interface which must be implemented by all the entities.
 *
 * All game objects in a game made with XtremeEngine are entities. An entity can be made up of
 * several components that add functionality to it. For instance, an entity can have a physics
 * component to add physical behavior and a component which adds a shape to the scene to display the
 * entity.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IEntity extends ICoreObject extends IEntityComponentCollection extends IUpdateable extends INamed {
    /**
	 * Calls the onReset() method on all the components of the entity.
	 */
	public function resetComponents():Void;

    /**
	 * Called when the entity is added to the entity manager.
	 */
	public function onAdd():Void;
	
	/**
	 * Called when the entity is removed from the entity manager.
	 */
	public function onRemove():Void;

    /**
	 * The entity manager that owns the entity.
	 */
	public var owner(get, set):IEntityManager;
}
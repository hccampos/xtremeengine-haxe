package xtremeengine.entitycomponent;

import xtremeengine.ICore;
import xtremeengine.INamed;
import xtremeengine.IUpdateable;

/**
 * Interface which must be implemented by all the components of the entity-component system in
 * XtremeEngine.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IEntityComponent extends INamed extends IUpdateable {
	/**
	 * Called when the component is added to an entity.
	 */
	public function onAdd():Void;
	
	/**
	 * Called when another component is added or removed from the entity. This method should be used
	 * by the component to aquire or release references to other components in the entity.
	 */
	public function onReset():Void;
	
	/**
	 * Called when the component is removed from an entity.
	 */
	public function onRemove():Void;
	
	/**
	 * The entity who owns the component (i.e. the entity to which the component has been added).
	 */
	public var owner(get, set):IEntity;

    /**
     * The core object to which the component belongs.
     */
    public var core(get, never):ICore;
}
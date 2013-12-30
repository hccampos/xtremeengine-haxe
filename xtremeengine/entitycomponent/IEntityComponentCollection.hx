package xtremeengine.entitycomponent;

/**
 * Interface which defines a collection of entity components.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IEntityComponentCollection {
    /**
	 * Adds the specified component to the collection.
	 *
	 * @param component
	 * 		The component which is to be added.
	 */
	public function addComponent(component:IEntityComponent):Void;
	
	/**
	 * Removes the specified component from the collection.
	 *
	 * @param component
	 * 		The component which is to be removed.
	 *
	 * @return True if the component was removed and false otherwise.
	 */
	public function removeComponent(component:IEntityComponent):Bool;
	
	/**
	 * Removes the component which is identified by the specified name from the collection.
	 *
	 * @param name
	 * 		The name of the component which is to be removed.
	 *
	 * @return True if the component was removed and false otherwise.
	 */
	public function removeComponentByName(name:String):Bool;
	
	/**
	 * Removes all the components from the collection.
	 */
	public function removeAllComponents():Void;
	
	/**
	 * Gets the component which has the specified name.
     *
     * @param name
     *      The name of the component which is to be retrieved.
	 */
	public function getComponentByName(name:String):IEntityComponent;

    /**
     * Gets the first component of the specified type.
     *
     * @param cls
     *      The type of component that is to be retrieved.
     */
    public function getComponentByType<T: IEntityComponent>(cls:Class<T>):T;
	
	/**
	 * Gets an array with all the components of the specified type.
	 */
	public function getComponentsByType<T: IEntityComponent>(cls:Class<T>):Array<T>;

    /**
     * Gets whether the collection has the specified component.
     *
     * @param component
     *      The component which is to be found.
     *
     * @return True if the collection has the component and false otherwise.
     */
    public function hasComponent(component:IEntityComponent):Bool;

    /**
     * Gets whether the collection has a component with the specified name.
     *
     * @param name
     *      The name of the component which is to be found.
     *
     * @return True if the collection has the component and false otherwise.
     */
    public function hasComponentNamed(name:String):Bool;
}
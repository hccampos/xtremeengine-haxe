package xtremeengine.physics;

/**
 * Interface which defines a collection of physics controllers.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IPhysicsControllerCollection {
    /**
	 * Adds a controller to the collection.
	 *
	 * @param controller
	 * 		The controller which is to be added.
	 */
	public function addPhysicsController(controller:IPhysicsController):Void;
	
	/**
	 * Removes a controller from the collection.
	 *
	 * @param controller
	 * 		The controller which is to be removed.
     *
     * @return True if the controller was removed and false otherwise.
	 */
	public function removePhysicsController(controller:IPhysicsController):Bool;
	
    /**
	 * Removes the controller which is identified by the specified name from the collection.
	 *
	 * @param name
	 * 		The name of the controller which is to be removed.
	 *
	 * @return True if the controller was removed and false otherwise.
	 */
    public function removePhysicsControllerByName(name:String):Bool;

    /**
	 * Removes all the controllers from the collection.
	 */
	public function removeAllPhysicsControllers():Void;

    /**
	 * Gets the controller which has the specified name.
     *
     * @param name
     *      The name of the controller which is to be retrieved.
     *
     * @return The controller which has the specified name or null if the controller can't be found.
	 */
	public function getPhysicsControllerByName(name:String):IPhysicsController;

    /**
	 * Gets whether the collection has the specified controller.
	 *
	 * @param entity
	 * 		The entity which is to be found.
	 *
	 * @return True if the collection has the specified entity and false otherwise.
	 */
	public function hasPhysicsController(controller:IPhysicsController):Bool;

    /**
     * Gets whether the collection has a physics controller with the specified name.
     *
     * @param name
     *      The name of the controller which is to be found.
     *
     * @return True if the collection has the controller and false otherwise.
     */
    public function hasPhysicsControllerNamed(name:String):Bool;

    /**
	 * The physics controllers that are part of the collection.
	 */
	public var physicsControllers(get, never):Array<IPhysicsController>;
}
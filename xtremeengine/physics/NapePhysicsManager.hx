package xtremeengine.physics;

import xtremeengine.errors.Error;
import xtremeengine.ICore;
import xtremeengine.physics.IPhysicsController;
import xtremeengine.CorePlugin;
import xtremeengine.utils.Vec2;

/**
 * Physics manager which integrates NAPE into the XtremeEngine.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class NapePhysicsManager extends CorePlugin implements IPhysicsManager {
    private var _gravity:Vec2;
    private var _controllers:Array<IPhysicsController>;
    private var _isEnabled:Bool;
    private var _updateOrder:Int;

    //--------------------------------------------------------------------------------------------//

    /**
     * Initializes a new NAPE physics manager instance.
     *
     * @param core
     *      The core object to which the manager belongs.
     * @param name
     *      The name of the manager.
     */
    public function new(core:ICore, name:String):Void {
        super(core, name);

        _controllers = new Array<IPhysicsController>();
        _isEnabled = true;
        _updateOrder = 0;
    }

    //--------------------------------------------------------------------------------------------//
    //{ Public Methods
    //--------------------------------------------------------------------------------------------//

    /**
     * Updates the physics manager.
     *
     * @param elapsedMillis
     *      The time that has passed since the last update.
     */
    public function update(elapsedMillis:Float):Void {
        for (controller in _controllers) {
            if (controller.isEnabled) { controller.update(elapsedMillis); }
        }
    }

    /**
	 * Adds a controller to the physics manager.
	 *
	 * @param controller
	 * 		The controller which is to be added.
	 */
    public function addPhysicsController(controller:IPhysicsController):Void {
        if (controller == null) { throw new Error("Trying to add null physics controller."); }
        if (this.hasPhysicsController(controller)) {
            throw new Error("Trying to add a controller which has already been added to the physics manager.");
        }

        _controllers.push(controller);
    }

    /**
	 * Removes a controller from the physics manager.
	 *
	 * @param controller
	 * 		The controller which is to be removed.
	 */
    public function removePhysicsController(controller:IPhysicsController):Bool {
        if (controller == null) { return false; }
        return _controllers.remove(controller);
    }

    /**
	 * Removes the controller which is identified by the specified name from the collection.
	 *
	 * @param name
	 * 		The name of the controller which is to be removed.
	 *
	 * @return True if the controller was removed and false otherwise.
	 */
    public function removePhysicsControllerByName(name:String):Bool {
        return this.removePhysicsController(this.getPhysicsControllerByName(name));
    }

    /**
	 * Removes all the controllers from the collection.
	 */
	public function removeAllPhysicsControllers():Void {
        var toRemove:Array<IPhysicsController> = _controllers.concat([]);
        for (controller in _controllers) {
            this.removePhysicsController(controller);
        }
    }

    /**
	 * Gets the controller which has the specified name.
     *
     * @param name
     *      The name of the controller which is to be retrieved.
     *
     * @return The controller which has the specified name or null if the controller can't be found.
	 */
	public function getPhysicsControllerByName(name:String):IPhysicsController {
        if (name == null || name == "") { return null; }

        for (controller in _controllers) {
            if (controller.name == name) { return controller; }
        }

        return null;
    }

    /**
	 * Gets whether the physics manager has the specified controller.
	 *
	 * @param entity
	 * 		The entity which is to be found.
	 *
	 * @return True if the collection has the specified entity and false otherwise.
	 */
	public function hasPhysicsController(controller:IPhysicsController):Bool {
        return Lambda.has(_controllers, controller);
    }

    /**
     * Gets whether the collection has a physics controller with the specified name.
     *
     * @param name
     *      The name of the controller which is to be found.
     *
     * @return True if the collection has the controller and false otherwise.
     */
    public function hasPhysicsControllerNamed(name:String):Bool {
        return this.getPhysicsControllerByName(name) != null;
    }

    //}
    //--------------------------------------------------------------------------------------------//

    //--------------------------------------------------------------------------------------------//
    //{ Properties
    //--------------------------------------------------------------------------------------------//

    /**
	 * The physics controllers that are managed by the physics manager.
	 */
	public var physicsControllers(get, never):Array<IPhysicsController>;
    private inline function get_physicsControllers():Array<IPhysicsController> { return _controllers; }

    /**
     * The gravity applied to all the physics objects.
     */
    public var gravity(get, set):Vec2;
    private inline function get_gravity():Vec2 { return _gravity; }
    private inline function set_gravity(value:Vec2):Vec2 { return _gravity = value; }

    /**
     * Whether the physics manager is enabled.
     */
    public var isEnabled(get, set):Bool;
    private inline function get_isEnabled():Bool { return _isEnabled; }
    private inline function set_isEnabled(value:Bool):Bool { return _isEnabled = value; }

    /**
     * The update order of the physics manager.
     */
    public var updateOrder(get, set):Int;
    private inline function get_updateOrder():Int { return _updateOrder; }
    private inline function set_updateOrder(value:Int):Int { return _updateOrder = value; }

    //}
    //--------------------------------------------------------------------------------------------//
}
package xtremeengine.scene;

import xtremeengine.Context;
import xtremeengine.CorePlugin;
import xtremeengine.errors.Error;
import xtremeengine.ICore;

/**
 * Default implementation of the ISceneManager interface.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class SceneManager extends CorePlugin implements ISceneManager {
    private var _sceneContext:Context;
	private var _rootSceneNode:ISceneNode;
	private var _activeCamera:ICamera;
	private var _cameras:Array<ICamera>;
	private var _isEnabled:Bool;
	private var _updateOrder:Int;
	
	/**
	 * Initializes the scene manager.
	 *
	 * @param core
	 * 		The core object to which the scene manager belongs.
	 * @param name
	 * 		The name of the scene manager.
	 */
	public function new(core:ICore, name:String):Void {
		super(core, name);
		
        _sceneContext = new Context();
		_rootSceneNode = new SceneNode(this, _sceneContext);
		_activeCamera = null;
		_cameras = new Array<ICamera>();
        _isEnabled = true;
        _updateOrder = 0;
	}
	
	/**
	 * Initializes the scene manager.
	 */
	public override function initialize():Void {
        this.core.context.addChild(_sceneContext);

        super.initialize();
	}
	
	/**
	 * Destroys the scene manager and any resources aquired by it.
	 */
	public override function destroy():Void {
        rootSceneNode.removeDescendants();
        this.core.context.removeChild(_sceneContext);

        super.destroy();
	}
	
	/**
	 * Updates the scene manager.
	 *
	 * @param elapsedTime
	 * 		The number of milliseconds elapsed since the last update.
	 */
	public function update(elapsedMillis:Float):Void {
		if (_activeCamera != null) {
			_rootSceneNode.rotation = -_activeCamera.rotation;
			_rootSceneNode.scale = _activeCamera.scale;
			_rootSceneNode.x = -_activeCamera.x;
			_rootSceneNode.y = -_activeCamera.y;
		}
	}
	
	/**
	 * Adds a new camera to the scene.
	 *
	 * @param camera
	 * 		The camera which is to be added.
	 */
	public function addCamera(camera:ICamera):Void {
        if (camera == null) {
            throw new Error("Trying to add a null camera to the scene manager.");
        }

        if (this.hasCamera(camera)) {
            throw new Error("Trying to add a camera which has already been added to the scene manager");
        }

		_cameras.push(camera);
	}
	
	/**
	 * Removes a camera from the scene.
	 *
	 * @param camera
	 * 		The camera which is to be removed.
	 *
	 * @return True if the camera was removed and false otherwise.
	 */
	public function removeCamera(camera:ICamera):Bool {
        if (camera == null) { return false; }
		return _cameras.remove(camera);
	}
	
	/**
	 * Removes the camera which is identified by the specified name from the scene.
	 *
	 * @param name
	 * 		The name of the camera which is to be removed.
	 *
	 * @return True if the camera was removed and false otherwise.
	 */
	public function removeCameraByName(name:String):Bool {
		return this.removeCamera(this.getCameraByName(name));
	}

    /**
	 * Removes all the cameras from the collection.
	 */
	public function removeAllCameras():Void {
        var toRemove:Array<ICamera> = _cameras.concat([]);
        for (camera in toRemove) {
            this.removeCamera(camera);
        }
    }
	
	/**
	 * Gets the camera which is identified by the specified name.
	 *
	 * @param name
	 * 		The name of the camera which is to be retrieved.
	 *
	 * @return The camera which is identified by the specified name. Null if the camera could not be
	 * found.
	 */
	public function getCameraByName(name:String):ICamera {
        if (name == null || name == "") { return null; }

		for (camera in _cameras) {
			if (camera.name == name) { return camera; }
		}
		
		return null;
	}
	
    /**
	 * Gets whether the collection has the specified camera.
	 *
	 * @param camera
	 * 		The camera which is to be found.
	 *
	 * @return True if the collection has the specified camera and false otherwise.
	 */
	public function hasCamera(camera:ICamera):Bool {
        return Lambda.has(_cameras, camera);
    }

   /**
	 * Gets whether the collection has the specified camera.
	 *
	 * @param name
	 * 		The name of the camera which is to be found.
	 *
	 * @return True if the collection has the specified camera and false otherwise.
	 */
    public function hasCameraNamed(name:String):Bool {
        return this.getCameraByName(name) != null;
    }

    /**
	 * Activates the camera identified by the specified name.
	 *
	 * @param name
	 * 		The name of the camera which is to be activated.
	 */
	public function setActiveCameraByName(name:String):Void {
		var camera:ICamera = this.getCameraByName(name);
		if (camera != null) { this.activeCamera = camera; }
	}

    //--------------------------------------------------------------------------------------------//
    //{ Properties
    //--------------------------------------------------------------------------------------------//

    /**
     * Create a new scene node.
     *
     * @return The newly created scene node.
     */
    public function createSceneNode():ISceneNode {
        return new SceneNode(this);
    }

    /**
     * Creates a new camera.
     *
     * @param name
     *      The name of the new camera.
     *
     * @return The newly created camera.
     */
    public function createCamera(name:String):ICamera {
        return new Camera(this, name);
    }

	/**
	 * The camera which is currently active.
	 */
	public var activeCamera(get, set):ICamera;
	private inline function get_activeCamera():ICamera { return _activeCamera; }
	private inline function set_activeCamera(camera:ICamera):ICamera {
		if (camera != null && Lambda.has(_cameras, camera)) {
            return _activeCamera = camera;
        } else {
            return _activeCamera = null;
        }
	}
	
	/**
	 * The cameras being managed by the scene manager.
	 */
	public var cameras(get, never):Array<ICamera>;
	private inline function get_cameras():Array<ICamera> { return _cameras;  }
	
	/**
	 * Whether the scene manager is enabled.
	 */
	public var isEnabled(get, set):Bool;
	private inline function get_isEnabled():Bool { return _isEnabled; }
	private inline function set_isEnabled(value:Bool):Bool { return _isEnabled = value; }
	
	/**
	 * Value which indicates the order in which the scene manager is to be updated.
	 */
	public var updateOrder(get, set):Int;
	private inline function get_updateOrder():Int { return _updateOrder; }
	private inline function set_updateOrder(value:Int):Int { return _updateOrder = value; }

    /**
	 * The scene node which contains the scene.
	 */
	public var rootSceneNode(get, never):ISceneNode;
	private inline function get_rootSceneNode():ISceneNode { return _rootSceneNode; }
	private inline function set_rootSceneNode(value:ISceneNode):ISceneNode {
		return _rootSceneNode = value;
	}

    //}
    //--------------------------------------------------------------------------------------------//
}
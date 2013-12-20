package xtremeengine.scene;

/**
 * Interface which defines a collection of cameras.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface ICameraCollection
{
    /**
	 * Adds the specified camera to the collection.
	 *
	 * @param camera
	 * 		The camera which is to be added.
	 */
	public function addCamera(camera:Camera):Void;
	
	/**
	 * Removes the specified camera from the collection.
	 *
	 * @param camera
	 * 		The camera which is to be removed.
	 *
	 * @return True if the camera was removed and false otherwise.
	 */
	public function removeCamera(camera:Camera):Bool;

	/**
	 * Removes the camera which is identified by the specified name from the collection.
	 *
	 * @param name
	 * 		The name of the camera which is to be removed.
	 *
	 * @return True if the camera was removed and false otherwise.
	 */
	public function removeCameraByName(name:String):Bool;
	
    /**
	 * Removes all the cameras from the collection.
	 */
	public function removeAllCameras():Void;

	/**
	 * Gets the camera which is identified by the specified name.
	 *
	 * @param name
	 * 		The name of the camera which is to be retrieved.
	 *
	 * @return The camera which is identified by the specified name.
	 */
	public function getCameraByName(name:String):Camera;

    /**
	 * Gets whether the collection has the specified camera.
	 *
	 * @param camera
	 * 		The camera which is to be found.
	 *
	 * @return True if the collection has the specified camera and false otherwise.
	 */
	public function hasCamera(camera:Camera):Bool;

   /**
	 * Gets whether the collection has the specified camera.
	 *
	 * @param name
	 * 		The name of the camera which is to be found.
	 *
	 * @return True if the collection has the specified camera and false otherwise.
	 */
    public function hasCameraNamed(name:String):Bool;

    /**
	 * The cameras that are in the collection.
	 */
	public var cameras(get, never):Array<Camera>;
}
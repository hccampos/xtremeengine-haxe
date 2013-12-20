package xtremeengine.scene;

import xtremeengine.IPlugin;
import xtremeengine.IUpdateable;

/**
 * Interface which must be implemented by a camera manager.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface ISceneManager extends IPlugin extends IUpdateable extends ICameraCollection
{
	/**
	 * Activates the camera which is identified by the specified name.
	 *
	 * @param name
	 * 		The name of the camera which is to be activated.
	 */
	public function setActiveCameraByName(name:String):Void;
	
	/**
	 * The camera which is currently active.
	 */
	public var activeCamera(get, set):Camera;

    /**
	 * The scene node which contains the scene.
	 */
	public var rootSceneNode(get, never):SceneNode;
}
package xtremeengine.scene;

import xtremeengine.scene.ISceneManager;

/**
 * Simple camera used to position and scale the scene container.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class Camera extends SceneNode implements ICamera {
    private var _name:String;

	/**
	 * Initializes a new camera.
	 *
	 * @param sceneManager
	 *      The scene manager to which the camera belongs.
     * @param name
     *      The name of the camera.
	 */
	public function new(sceneManager:ISceneManager, name:String) {
        super(sceneManager);
        _name = name;
	}

    /**
     * The name of the scene node.
     */
    public var name(get, never):String;
    private function get_name():String { return _name; }
}
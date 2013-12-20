package xtremeengine.scene;

import xtremeengine.ICore;
import xtremeengine.INamed;

/**
 * Simple camera used to position and scale the scene container.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class Camera extends SceneNode implements INamed
{
    private var _name:String;

	/**
	 * Initializes a new camera.
     *
     * @param core
     *      The core object to which the camera belongs.
     * @param name
     *      The name of the camera.
	 */
	public function new(core:ICore, name:String)
	{
		super(core);
        _name = name;
	}

    /**
     * The name of the scene node.
     */
    public var name(get, never):String;
    private function get_name():String { return _name; }
}
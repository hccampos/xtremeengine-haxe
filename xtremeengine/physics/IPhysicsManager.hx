package xtremeengine.physics;

import xtremeengine.utils.Vec2;
import xtremeengine.IPlugin;
import xtremeengine.IUpdateable;

/**
 * Interface which must be implemented by all the physics manager.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IPhysicsManager extends IPlugin extends IUpdateable extends IPhysicsControllerCollection
{
	/**
	 * The gravity force which is applied to all the physics objects.
	 */
	public var gravity(get, set):Vec2;
}
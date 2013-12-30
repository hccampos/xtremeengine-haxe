package xtremeengine.scene;

import xtremeengine.utils.Vec2;

/**
 * Interface which must be implemented by all the objects that have a position.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IPositionable {
    /**
     * The position of the object.
     */
	public var position(get, set):Vec2;

    /**
     * The position of the object along the X axis.
     */
	public var x(get, set):Float;

    /**
     * The position of the object along the Y axis.
     */
	public var y(get, set):Float;
}
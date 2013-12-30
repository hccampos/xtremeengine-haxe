package xtremeengine.scene;

import xtremeengine.utils.Vec2;

/**
 * Interface which must be implemented by all the objects that can be scaled.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IScalable {
    /**
     * The scale of the object.
     */
	public var scale(get, set):Vec2;

    /**
     * The scale of the object along the X axis.
     */
    public var scaleX(get, set):Float;

    /**
     * The scale of the object along the Y axis.
     */
    public var scaleY(get, set):Float;
}
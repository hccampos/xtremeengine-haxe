package xtremeengine.scene;

/**
 * Interface which must be implemented by all the objects that can be rotated.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IRotateable
{
    /**
     * The rotation of the object (in radians).
     */
	public var rotation(get, set):Float;
}
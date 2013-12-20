package xtremeengine;

/**
 * Interface which should be implemented by all of the XtremeEngine objects that belong to a Core
 * object.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface ICoreObject
{
	/**
	 * The XtremeEngine Core object to which the object belongs.
	 */
	public var core(get, never):ICore;
}
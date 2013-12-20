package xtremeengine;

/**
 * Interface which must be implemented by all the classes that wish to be updated by XtremeEngine.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IUpdateable
{
    /**
	 * Updates the state of the object.
	 *
	 * @param elapsedTime
	 * 		The number of milliseconds elapsed since the last update.
	 */
	public function update(elapsedMillis:Float):Void;

	/**
	 * Whether the object is enabled.
	 */
	public var isEnabled(get, set):Bool;
	
	/**
	 * Value used to sort objects before updating.
	 */
	public var updateOrder(get, set):Int;
}
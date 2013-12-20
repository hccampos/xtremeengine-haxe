package xtremeengine;

/**
 * Interface which defines objects that can be initialized and destroyed.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IInitializable
{
    /**
	 * Initializes the object.
	 */
	public function initialize():Void;
	
	/**
	 * Called before the object is destroyed.
	 */
	public function destroy():Void;

    /**
     * Whether the object is initialized.
     */
    public var isInitialized(get, never):Bool;
}
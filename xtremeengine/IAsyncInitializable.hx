package xtremeengine;
import promhx.Promise.Promise;

/**
 * Interface which defines objects that can be initialized and destroyed asynchronously.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IAsyncInitializable
{
    /**
	 * Initializes the object.
     *
     * @return A promise which is resolved when the object has been initialized.
	 */
	public function initialize():Promise<Bool>;
	
	/**
	 * Called before the object is destroyed.
     *
     * @return A promise which is resolved when the object has been destroyed.
	 */
	public function destroy():Promise<Bool>;

    /**
     * Whether the object is initialized.
     */
    public var isInitialized(get, never):Bool;
}
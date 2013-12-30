package xtremeengine;
import promhx.Promise.Promise;

/**
 * Interface which must be implemented by objects that can be loaded.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface ILoadable {
    /**
     * Loads any required resources.
     */
    public function load():Promise<Bool>;

    /**
     * Unloads any resources that may have been loaded.
     */
    public function unload():Promise<Bool>;

    /**
     * Whether the object is loaded.
     */
    public var isLoaded(get, never):Bool;
}
package xtremeengine.content;

import xtremeengine.IPlugin;
import xtremeengine.IUpdateable;

/**
 * Interface which must be implemented by all the content managers.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IContentManager extends IPlugin {
    /**
     * Gets whether assets of the specified format can be loaded.
     *
     * @param format
     *      The format which is to be tested.
     *
     * @return True if assets of the specified format can be loaded and false otherwise.
     */
    public function canLoad(format:String):Bool;

	/**
	 * Array with all the formats that are supported by the content manager.
	 */
	public var formats(get, never):Array<String>;
}
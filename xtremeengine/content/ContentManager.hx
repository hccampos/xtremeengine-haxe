package xtremeengine.content;

import xtremeengine.ICore;
import xtremeengine.APlugin;

/**
 * ...
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class ContentManager extends APlugin implements IContentManager
{
    private var _formats:Array<String>;

    public function new(core:ICore, name:String):Void
    {
        super(core, name);
        _formats = new Array<String>();
    }

    /**
	 * Initializes the plugin.
	 */
	public override function initialize():Void {
        super.initialize();
    }
	
	/**
	 * Called before the plugin is removed from the core object or when the core object is about to
	 * be destroyed. The plugin should destroy any resources it may have created.
	 */
	public override function destroy():Void {
        super.destroy();
    }

    /**
     * Gets whether assets of the specified format can be loaded.
     *
     * @param format
     *      The format which is to be tested.
     *
     * @return True if assets of the specified format can be loaded and false otherwise.
     */
    public function canLoad(format:String):Bool
    {
        return true;
    }

    /**
	 * Array with all the formats that are supported by the content manager.
	 */
	public var formats(get, never):Array<String>;
    private inline function get_formats():Array<String> { return _formats; }
}
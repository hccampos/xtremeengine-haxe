package xtremeengine;

import xtremeengine.errors.Error;
import flash.events.EventDispatcher;

/**
 * Base class for objects that belong to an XtremeEngine core object.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class CoreObject extends EventDispatcher implements ICoreObject
{
	private var _core:ICore;

	/**
	 * Constructor.
	 *
	 * @param core
	 * 		The core object to which the object being created belongs.
	 */
	public function new(core:ICore):Void
	{
        super();

		if (core == null) {
			throw new Error("Null Core object.");
		}
		
		_core = core;
	}
	
	/**
	 * The core object to which the object belongs.
	 */
	public var core(get, never):ICore;
	private inline function get_core():ICore { return _core; }
}
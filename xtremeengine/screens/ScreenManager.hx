package xtremeengine.screens;

import xtremeengine.Plugin;

/**
 * Default implementation of the IScreenManager interface.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class ScreenManager extends Plugin implements IScreenManager
{
    private var _screens:Array<IScreen>;
    private var _screensToUpdate:Array<IScreen>;
    private var _isLoaded:Bool;
    private var _isEnabled:Bool;
    private var _updateOrder:Int;

    //--------------------------------------------------------------------------------------------//

    /**
     * Constructor.
     *
     * @param name
     *      The name of the screen manager.
     */
    public function new():Void
    {
        _screens = new Array<IScreen>();
        _screensToUpdate = new Array<IScreen>();
        _isLoaded = false;
        _isEnabled = true;
        _updateOrder = 0;
    }

    //--------------------------------------------------------------------------------------------//
    //{ Public Methods
    //--------------------------------------------------------------------------------------------//

    /**
	 * Updates each screen.
	 *
	 * @param elapsedTime
	 * 		The number of milliseconds elapsed since the last update.
	 */
	public function update(elapsedMillis:Float):Void
    {

    }

    /**
     * Adds the specified screen to the screen manager.
     *
     * @param screen
     *      The screen which is to be added.
     */
    public function addScreen(screen:IScreen):Void
    {

    }

    /**
     * Removes the specified screen from the screen manager. You should normally use IScreen.exit()
     * instead of calling this directly, so the screen can gradually transition off rather than just
     * being instantly removed.
     *
     * @param screen
     *      The screen which is to be removed.
     */
    public function removeScreen(screen:IScreen):Bool
    {
        return true;
    }

    /**
     * Removes all the screens from the collection.
     * @return
     */
    public function removeAllScreens():Void
    {

    }

    /**
     * Gets whether the collection has the specified screen.
     *
     * @param screen
     *      The screen which is to be found.
     *
     * @return True if the collection has the specified screen and false otherwise.
     */
    public function hasScreen(screen:IScreen):Bool
    {
        return true;
    }

    /**
     * Loads any required resources required by the screen manager or any of the screens managed by
     * it.
     */
    public function load():Void
    {
        if (_isLoaded) { return; }

        _isLoaded = true;
    }

    /**
     * Unloads any resources that may have been loaded by the screen manager.
     */
    public function unload():Void
    {
        if (!_isLoaded) { return; }

        _isLoaded = false;
    }

    //--------------------------------------------------------------------------------------------//
    //{ Properties
    //--------------------------------------------------------------------------------------------//

    /**
     * The screens that make up the collection.
     */
    public var screens(get, never):Array<IScreen>;
    public inline function get_screens():Array<IScreen> { return _screens; }

    /**
     * Whether the screen manager has been loaded.
     */
    public var isLoaded(get, never):Bool;
    private inline function get_isLoaded():Bool { return _isLoaded; }

    /**
     * Whether the screen manager is enabled.
     */
    public var isEnabled(get, set):Bool;
    private inline function get_isEnabled():Bool { return _isEnabled; }
    private inline function set_isEnabled(value:Bool):Bool { return _isEnabled = value; }

    /**
     * The update order of the screen manager.
     */
    public var updateOrder(get, set):Int;
    private inline function get_updateOrder():Int { return _updateOrder; }
    private inline function set_updateOrder(value:Int):Int { return _updateOrder = value; }

    //--------------------------------------------------------------------------------------------//
}
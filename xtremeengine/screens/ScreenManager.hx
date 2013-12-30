package xtremeengine.screens;

import promhx.Promise;
import xtremeengine.Plugin;
import xtremeengine.utils.PromiseUtils;

/**
 * Default implementation of the IScreenManager interface.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class ScreenManager implements IScreenManager {
    private var _screens:Array<IScreen>;
    private var _isInitialized:Bool;
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
    public function new():Void {
        _isInitialized = false;
        _isLoaded = false;
        _isEnabled = true;
        _updateOrder = 0;
    }

    //--------------------------------------------------------------------------------------------//
    //{ Public Methods
    //--------------------------------------------------------------------------------------------//

    /**
	 * Initializes the object.
	 */
	public function initialize():Void {
        if (_isInitialized) { return; }
        _screens = new Array<IScreen>();
        _isInitialized = true;
    }

	/**
	 * Called before the manager is destroyed.
	 */
	public function destroy():Void {
        if (!_isInitialized) { return; }

        this.unload();
        _screens = new Array<IScreen>();

        _isInitialized = false;
    }

    /**
     * Loads any required resources required by the screen manager or any of the screens managed by
     * it.
     */
    public function load():Promise<Bool> {
        if (_isLoaded) { return PromiseUtils.resolved(true); }

        var promises:Array<Promise<Bool>> = new Array<Promise<Bool>>();
        for (screen in _screens) {
            promises.push(screen.load());
        }

        return Promise.whenAll(promises).then(function (result):Bool {
            _isLoaded = true;
            return true;
        });
    }

    /**
     * Unloads any resources that may have been loaded by the screen manager.
     */
    public function unload():Promise<Bool> {
        if (!_isLoaded) { return PromiseUtils.resolved(true); }

        var promises:Array<Promise<Bool>> = new Array<Promise<Bool>>();
        for (screen in _screens) {
            promises.push(screen.unload());
        }

        return Promise.whenAll(promises).then(function (result):Bool {
            _isLoaded = false;
            return true;
        });
    }

    /**
	 * Updates each screen.
	 *
	 * @param elapsedTime
	 * 		The number of milliseconds elapsed since the last update.
	 */
	public function update(elapsedMillis:Float):Void {
        // Make a copy of the master screen list, to avoid confusion if the process of updating one
        // screen adds or removes others.
        var toUpdate:Array<IScreen> = _screens.concat([]);

        var otherScreenHasFocus = false;
        var isCovered = false;

        var screen:IScreen = null;
        while ((screen = toUpdate.pop()) != null) {
            screen.update(elapsedMillis, otherScreenHasFocus, isCovered);

            if (screen.state == EScreenState.TransitionOn || screen.state == EScreenState.Active) {
                // If this is the first screen that we come across we give a chance to handle input.
                // The handleInput method won't be called for subsequent screens.
                if (!otherScreenHasFocus) {
                    screen.handleInput(elapsedMillis);
                    otherScreenHasFocus = true;
                }

                // If the screen is not popup, we have to inform all the next screens that they are
                // covered by it.
                if (!screen.isPopup) { isCovered = true; }
            }
        }
    }

    /**
     * Adds the specified screen to the screen manager.
     *
     * @param screen
     *      The screen which is to be added.
     */
    public function addScreen(screen:IScreen):Promise<Bool> {
        return screen.load().then(function (result):Bool {
            _screens.push(screen);
            return true;
        });
    }

    /**
     * Removes the specified screen from the screen manager. You should normally use IScreen.exit()
     * instead of calling this directly, so the screen can gradually transition off rather than just
     * being instantly removed.
     *
     * @param screen
     *      The screen which is to be removed.
     *
     * @return True if the screen was removed and false otherwise.
     */
    public function removeScreen(screen:IScreen):Promise<Bool> {
        if (!this.hasScreen(screen)) { return PromiseUtils.resolved(false); }

        return screen.unload().then(function (result):Bool {
            return _screens.remove(screen);
        });
    }

    /**
     * Removes all the screens from the collection.
     */
    public function removeAllScreens():Promise<Bool> {
        var toRemove = _screens.concat([]);

        var promises:Array<Promise<Bool>> = new Array<Promise<Bool>>();
        for (screen in toRemove) {
            promises.push(this.removeScreen(screen));
        }

        return PromiseUtils.sequence(promises).then(function (result):Bool {
            return true;
        });
    }

    /**
     * Gets whether the collection has the specified screen.
     *
     * @param screen
     *      The screen which is to be found.
     *
     * @return True if the collection has the specified screen and false otherwise.
     */
    public inline function hasScreen(screen:IScreen):Bool {
        return Lambda.has(_screens, screen);
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
     * Whether the screen manager has been initialized.
     */
    public var isInitialized(get, never):Bool;
    private inline function get_isInitialized():Bool { return _isInitialized; }

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
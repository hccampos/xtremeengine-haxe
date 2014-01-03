package xtremeengine;

import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import msignal.Signal.Signal0;
import msignal.Signal.Signal2;
import promhx.Promise.Promise;
import xtremeengine.content.IContentManager;
import xtremeengine.errors.Error;
import xtremeengine.screens.IScreenManager;
import xtremeengine.utils.PromiseUtils;

/**
 * Game base class.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class Game implements IGame
{
    private var _context:Context;
    private var _pluginFactory:IGamePluginFactory;

    private var _contentManager:IContentManager;
    private var _screenManager:IScreenManager;

    private var _plugins:Array<IGamePlugin>;
    private var _updateablePlugins:Array<IUpdateable>;
    private var _loadablePlugins:Array<ILoadable>;

    private var _isInitialized:Bool;
    private var _isLoaded:Bool;
    private var _targetFps:Int;
    private var _scaleMode:StageScaleMode;
    private var _align:StageAlign;
    private var _lastTime:Int;

    private var _onActivateSignal:Signal0;
    private var _onDeactivateSignal:Signal0;
    private var _onResizeSignal:Signal2<Float, Float>;

    //--------------------------------------------------------------------------------------------//

    /**
     * Creates the new game.
     */
    public function new(context:Context)
    {
        _context = context;
        _pluginFactory = new GamePluginFactory();

        _contentManager = null;
        _screenManager = null;

        _plugins = new Array<IGamePlugin>();
        _updateablePlugins = new Array<IUpdateable>();
        _loadablePlugins = new Array<ILoadable>();

        _isInitialized = false;
        _isLoaded = false;
        _targetFps = 60;
        _scaleMode = StageScaleMode.NO_SCALE;
        _align = StageAlign.TOP_LEFT;

        _onActivateSignal = new Signal0();
        _onDeactivateSignal = new Signal0();
        _onResizeSignal = new Signal2<Float, Float>();

        _context.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    //--------------------------------------------------------------------------------------------//
    //{ Public Methods
    //--------------------------------------------------------------------------------------------//

    /**
	 * Initializes the game.
     *
     * @return A promise which is resolved when the game has been initialized.
	 */
	public function initialize():Promise<Bool> {
        if (_isInitialized) { PromiseUtils.resolved(true); }
		
        this.setupStage();

        var factory:IGamePluginFactory = this.pluginFactory;

        _contentManager = factory.createContentManager(this, "contentManager");
        _screenManager = factory.createScreenManager(this, "screenManager");
        this.setupInitialScreens();

        this.addPlugin(_contentManager);
        this.addPlugin(_screenManager);

        for (plugin in _plugins) { plugin.initialize(); }

        return this.load().then(function (value):Bool {
            _isInitialized = true;
            return true;
        });
    }

    /**
	 * Releases any resources that were aquired by the game.
     *
     * @return A promise which is resolved when the game object has been destroyed.
	 */
	public function destroy():Promise<Bool> {
        if (!_isInitialized) { return PromiseUtils.resolved(true); }

        for (plugin in _plugins) { plugin.destroy(); }

        return this.unload().then(function (value):Bool {
            _contentManager = null;
            _screenManager = null;
            _plugins = new Array<IGamePlugin>();
            _updateablePlugins = new Array<IUpdateable>();
            _loadablePlugins = new Array<ILoadable>();
            _isInitialized = false;

            return true;
        });
	}

    /**
     * Loads all the loadable plugins.
     *
     * @return A promise which is resolved when all the plugins of added to the game have been
     * loaded.
     */
    public function load():Promise<Bool> {
        if (_isLoaded) { return PromiseUtils.resolved(true); }

        // Add all the promises to an array so we can wait for all the plugins to be loaded.
        var promises:Array<Promise<Bool>> = new Array<Promise<Bool>>();
        for (loadablePlugin in _loadablePlugins) {
            promises.push(loadablePlugin.load());
        }

        if (promises.length == 0) {
            _isLoaded = true;
            return PromiseUtils.resolved(true);
        }

        return Promise.whenAll(promises).then(function (values):Bool {
            _isLoaded = true;
            return true;
        });
    }

    /**
     * Unloads all the loadable plugins.
     *
     * @return A promise which is resolved when all the plugins added to the game have been
     * unloaded.
     */
    public function unload():Promise<Bool> {
        if (!_isLoaded) { return PromiseUtils.resolved(true); }

        // Add all the promises to an array so we can wait for all the plugins to be loaded.
        var promises:Array<Promise<Bool>> = new Array<Promise<Bool>>();
        for (loadablePlugin in _loadablePlugins) {
            promises.push(loadablePlugin.unload());
        }

        if (promises.length == 0) {
            _isLoaded = false;
            return PromiseUtils.resolved(true);
        }

        return Promise.whenAll(promises).then(function (values):Bool {
            _isLoaded = false;
            return true;
        });
    }

    /**
     * Installs the specified plugin in the engine.
     *
     * @param plugin
     *      The plugin which is to be installed.
     *
     * @return A promise which is resolved when the plugin has been installed.
     */
    public function installPlugin(plugin:IGamePlugin):Promise<Bool> {
        if (plugin == null) { return PromiseUtils.rejected(new Error("Intalling null plugin.")); }

        this.addPlugin(plugin);

        if (this.isInitialized) {
            plugin.initialize();
            return this.loadPlugin(plugin);
        } else {
            return PromiseUtils.resolved(true);
        }
    }

    /**
     * Uninstalls the specified plugin from the engine.
     *
     * @param plugin
     *      The plugin which is to be uninstalled.
     *
     * @return A promise which is resolved when the plugin has been uninstalled.
     */
    public function uninstallPlugin(plugin:IGamePlugin):Promise<Bool> {
        if (plugin == null) { return PromiseUtils.rejected(new Error("Uninstalling null plugin.")); }
        if (!Lambda.has(_plugins, plugin)) { return PromiseUtils.resolved(false); }

        return this.unloadPlugin(plugin).then(function (result):Bool {
            plugin.destroy();
            this.removePlugin(plugin);
            return true;
        });
    }

    /**
     * Gets the plugin with the specified name.
     *
     * @param name
     *      The name of the plugin which is to be retrieved.
     *
     * @return The plugin which has the specified name.
     */
    public function getPluginByName(name:String):IGamePlugin {
        if (name == null || name == "") { return null; }

        for (plugin in _plugins) {
            if (plugin.name == name) { return plugin; }
        }

        return null;
    }

	/**
	 * Gets the first plugin that has the specified type.
	 */
	public function getPluginByType<T:IGamePlugin>(cls:Class<T>):T {
        for (plugin in _plugins) {
            if (Std.is(plugin, cls)) {
                var ret:T = cast plugin;
                return ret;
            }
        }
		
		return null;
	}

    /**
	 * Gets an array with all the plugins of the specified type.
	 */
	public function getPluginsByType<T:IGamePlugin>(cls:Class<T>):Array<T> {
        var foundPlugins:Array<T> = new Array<T>();
		
		for (plugin in _plugins) {
			if (Std.is(plugin, cls)) {
				var foundPlugin:T = cast plugin;
				foundPlugins.push(foundPlugin);
			}
		}
		
		return foundPlugins;
    }

    /**
     * Gets whether the game has the specified plugin.
     *
     * @param plugin
     *      The plugin which is to be found.
     *
     * @return True if the game has the plugin and false otherwise.
     */
    public function hasPlugin(plugin:IGamePlugin):Bool {
        return Lambda.has(_plugins, plugin);
    }

    /**
     * Gets whether the game has a plugin with the specified name.
     *
     * @param name
     *      The name of the plugin which is to be found.
     *
     * @return True if the game has the plugin and false otherwise.
     */
    public function hasPluginNamed(name:String):Bool {
        return this.getPluginByName(name) != null;
    }

    //}
    //--------------------------------------------------------------------------------------------//

    //--------------------------------------------------------------------------------------------//
    //{ Private Methods
    //--------------------------------------------------------------------------------------------//

    /**
     * Creates the initial screens and adds them to the screen manager.
     */
    private function setupInitialScreens():Void {}

    /**
     * Configures and prepares the stage to which the context of the game has been added.
     */
    private function setupStage():Void {
        if (!this.hasValidContext) { throw new Error("No valid context or stage."); }

        var stage:Stage = this.context.stage;
        stage.align = this.align;
		stage.scaleMode = this.scaleMode;
		stage.frameRate = this.targetFps;

        stage.addEventListener(Event.ENTER_FRAME, update);
		stage.addEventListener(Event.ACTIVATE, onActivateHandler);
		stage.addEventListener(Event.DEACTIVATE, onDeactivateHandler);
        stage.addEventListener(Event.RESIZE, onResizeHandler);
    }

    /**
     * Loads a plugin but only if the plugin is ILoadable and if the game hasn't been loaded yet.
     *
     * @param plugin
     *      The plugin which is to be unloaded.
     *
     * @return A promise which is resolved when operation is complete.
     */
    private function loadPlugin(plugin:IGamePlugin):Promise<Bool> {
        if (this.isLoaded && Std.is(plugin, ILoadable)) {
            var loadablePlugin:ILoadable = cast plugin;
            return loadablePlugin.load();
        } else {
            return PromiseUtils.resolved(true);
        }
    }

    /**
     * Unloads a plugin but only if the plugin is ILoadable and if the game has already been
     * loaded.
     *
     * @param plugin
     *      The plugin which is to be unloaded.
     *
     * @return A promise which is resolved when operation is complete.
     */
    private function unloadPlugin(plugin:IGamePlugin):Promise<Bool> {
         if (this.isLoaded && Std.is(plugin, ILoadable)) {
            var loadablePlugin:ILoadable = cast plugin;
            return loadablePlugin.unload();
        } else {
            return PromiseUtils.resolved(true);
        }
    }

    /**
     * Adds a plugin.
     *
     * @param plugin
     *      The plugin which is to be added.
     */
    private function addPlugin(plugin:IGamePlugin):Void {
        _plugins.push(plugin);

        if (Std.is(plugin, IUpdateable)) {
            var updateablePlugin:IUpdateable = cast plugin;
            _updateablePlugins.push(updateablePlugin);
            _updateablePlugins.sort(function (a:IUpdateable, b:IUpdateable) {
                if (a.updateOrder == b.updateOrder) { return 0; }
                return a.updateOrder > b.updateOrder ? 1 : -1;
            });
        }

        if (Std.is(plugin, ILoadable)) {
            var loadablePlugin:ILoadable = cast plugin;
            _loadablePlugins.push(loadablePlugin);
        }
    }

    /**
     * Removes the specified plugin.
     *
     * @param plugin
     *      The plugin which is to be removed.
     *
     * @return True if the plugin was removed and false otherwise.
     */
    private function removePlugin(plugin:IGamePlugin):Bool {
        if (plugin == null) { return false; }
        if (!_plugins.remove(plugin)) { return false; }

        if (Std.is(plugin, IUpdateable)) {
            var updateablePlugin:IUpdateable = cast plugin;
            _updateablePlugins.remove(updateablePlugin);
        }

        if (Std.is(plugin, ILoadable)) {
            var loadablePlugin:ILoadable = cast plugin;
            _loadablePlugins.remove(loadablePlugin);
        }

        return true;
    }

    /**
     * Updates the game.
     */
    private function update(event:Event):Void {
        if (_lastTime == 0) {
			_lastTime = Lib.getTimer();
			return;
		}

		var currentTime:Int = Lib.getTimer();
		var elapsedMillis:Int = currentTime - _lastTime;
		_lastTime = currentTime;
		
		for (plugin in _updateablePlugins) {
            if (plugin.isEnabled) { plugin.update(elapsedMillis); }
        }
    }

    /**
     * Activates the game. This should be called when the window or app gains focus.
     */
    private function onActivateHandler(event:Event):Void {
        #if (mobile)
		_context.stage.frameRate = 1;
		#end

        this.onActivate.dispatch();
    }

    /**
     * Deactivates the game. This should be called when the window or app loses focus.
     */
    private function onDeactivateHandler(event:Event):Void {
        #if (mobile)
		_context.stage.frameRate = TARGET_FPS;
		#end

        this.onDeactivate.dispatch();
    }

    /**
	 * Called when the stage is resized.
	 *
	 * @param	event
	 * 		Object with the event details.
	 */
    private function onResizeHandler(event:Event):Void {
        if (!this.hasValidContext) { return; }

        var newWidth:Float = _context.stage.stageWidth;
        var newHeight:Float = _context.stage.stageHeight;

        this.onResize.dispatch(newWidth, newHeight);
    }

    /**
	 * Called when the context of the game has been added to the stage.
	 *
	 * @param	event
	 * 		Object with the event details.
	 */
	private function onAddedToStage(e) {
		_context.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

		#if ios
			haxe.Timer.delay(this.initialize, 100); // iOS 6
		#else
			this.initialize();
		#end
	}

    //}
    //--------------------------------------------------------------------------------------------//

    //--------------------------------------------------------------------------------------------//
    //{ Properties
    //--------------------------------------------------------------------------------------------//

    /**
     * Whether the game has been initialized.
     */
    public var isInitialized(get, never):Bool;
    private inline function get_isInitialized():Bool { return _isInitialized; }

    /**
     * Whether the game has been loaded.
     */
    public var isLoaded(get, never):Bool;
    private inline function get_isLoaded():Bool { return _isLoaded; }

    /**
     * The context where the game is to be displayed.
     */
    public var context(get, never):Context;
    private inline function get_context():Context { return _context; }

    /**
     * The plugin factory used to create the default plugins used by the game.
     */
    public var pluginFactory(get, set):IGamePluginFactory;
    private inline function get_pluginFactory():IGamePluginFactory { return _pluginFactory; }
    private inline function set_pluginFactory(value:IGamePluginFactory):IGamePluginFactory {
        return _pluginFactory = value;
    }

    /**
     * The content manager.
     */
    public var contentManager(get, never):IContentManager;
    private inline function get_contentManager():IContentManager { return _contentManager; }

    /**
     * The screen manager of the game.
     */
    public var screenManager(get, never):IScreenManager;
    private inline function get_screenManager():IScreenManager { return _screenManager; }

    /**
     * The width of the game screen/window.
     */
    public var width(get, never):Float;
    private inline function get_width():Float { return this.context.stage.stageWidth; }

    /**
     * The height of the game screen/window.
     */
    public var height(get, never):Float;
    private inline function get_height():Float { return this.context.stage.stageHeight; }

    /**
     * The target frame rate.
     */
    public var targetFps(get, set):Int;
    private inline function get_targetFps():Int { return _targetFps; }
    private inline function set_targetFps(value:Int):Int {
        _targetFps = value;
        if (this.hasValidContext) { _context.stage.frameRate = _targetFps; }
        return _targetFps;
    }

    /**
     * The scale mode of the stage.
     */
    public var scaleMode(get, set):StageScaleMode;
    private inline function get_scaleMode():StageScaleMode { return _scaleMode; }
    private inline function set_scaleMode(value:StageScaleMode):StageScaleMode {
        _scaleMode = value;
        if (this.hasValidContext) { _context.stage.scaleMode = _scaleMode; }
        return _scaleMode;
    }

    /**
     * The align mode of the stage.
     */
    public var align(get, set):StageAlign;
    private inline function get_align():StageAlign { return _align; }
    private inline function set_align(value:StageAlign) {
        _align = value;
        if (this.hasValidContext) { _context.stage.align = _align; }
        return _align;
    }

    /**
     * Whether the game has a valid context that is added to the stage.
     */
    public var hasValidContext(get, never):Bool;
    private inline function get_hasValidContext():Bool {
        return _context != null && _context.stage != null;
    }

    /**
     * Signal which is dispatched when the game is activated.
     */
    public var onActivate(get, never):Signal0;
    private inline function get_onActivate():Signal0 { return _onActivateSignal; }

    /**
     * Signal which is dispatched when the game is deactivated.
     */
    public var onDeactivate(get, never):Signal0;
    private inline function get_onDeactivate():Signal0 { return _onDeactivateSignal; }

    /**
     * Signal which is dispatched when the game is resized.
     */
    public var onResize(get, never):Signal2<Float, Float>;
    private inline function get_onResize():Signal2 <Float, Float> { return _onResizeSignal; }

    //}
    //--------------------------------------------------------------------------------------------//
}
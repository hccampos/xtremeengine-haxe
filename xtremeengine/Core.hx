package xtremeengine;

import promhx.Promise;
import xtremeengine.animation.IAnimationManager;
import xtremeengine.content.IContentManager;
import xtremeengine.entitycomponent.IEntityManager;
import xtremeengine.errors.Error;
import xtremeengine.gui.IGuiManager;
import xtremeengine.ICorePlugin;
import xtremeengine.input.IInputManager;
import xtremeengine.IUpdateable;
import xtremeengine.physics.IPhysicsManager;
import xtremeengine.scene.ISceneManager;
import xtremeengine.utils.PromiseUtils;

/**
 * Main class of XtremeEngine. It is responsible for managing all the managers of the engine and
 * making sure that everything fits together.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class Core extends GameObject implements ICore {
    private var _context:Context;
    private var _pluginFactory:ICorePluginFactory;

    private var _animationManager:IAnimationManager;
    private var _contentManager:IContentManager;
	private var _entityManager:IEntityManager;
    private var _guiManager:IGuiManager;
    private var _inputManager:IInputManager;
	private var _physicsManager:IPhysicsManager;
    private var _sceneManager:ISceneManager;

	private var _plugins:Array<ICorePlugin>;
	private var _updateablePlugins:Array<IUpdateable>;
    private var _loadablePlugins:Array<ILoadable>;
	private var _isInitialized:Bool;
    private var _isLoaded:Bool;
	
    //--------------------------------------------------------------------------------------------//

	/**
	 * Constructor.
     *
     * @param game
     *      The game to which the core belongs.
	 */
	public function new(game:IGame):Void {
        super(game);

        _context = game.context;

        _pluginFactory = new CorePluginFactory();
        _animationManager = null;
		_entityManager = null;
		_guiManager = null;
        _inputManager = null;
        _physicsManager = null;
        _sceneManager = null;

		_plugins = new Array<ICorePlugin>();
		_updateablePlugins = new Array<IUpdateable>();
        _loadablePlugins = new Array<ILoadable>();

		_isInitialized = false;
        _isLoaded = false;
	}
	
    //--------------------------------------------------------------------------------------------//
    //{ Public Methods
    //--------------------------------------------------------------------------------------------//
	
	/**
	 * Initializes the core and all its plugins.
     *
     * @return A promise which is resolved when the core object has been initialized.
	 */
	public function initialize():Promise<Bool> {
        if (_isInitialized) { return PromiseUtils.resolved(true); }

        var factory:ICorePluginFactory = this.pluginFactory;

		_sceneManager = factory.createSceneManager(this, "sceneManager");
        _physicsManager = factory.createPhysicsManager(this, "physicsManager");
		_entityManager = factory.createEntityManager(this, "entityManager");
        _guiManager = factory.createGuiManager(this, "guiManager");
        _inputManager = factory.createInputManager(this, "inputManager");
		_animationManager = factory.createAnimationManager(this, "animationManager");
		
        this.addPlugin(_inputManager);
        this.addPlugin(_sceneManager);
        this.addPlugin(_physicsManager);
        this.addPlugin(_animationManager);
        this.addPlugin(_guiManager);
        this.addPlugin(_entityManager);

        for (plugin in _plugins) { plugin.initialize(); }

        return this.load().then(function (value):Bool {
            _isInitialized = true;
            return true;
        });
	}

    /**
	 * Releases any resources that were aquired by the core object.
     *
     * @return A promise which is resolved when the core object has been destroyed.
	 */
	public function destroy():Promise<Bool> {
        if (!_isInitialized) { return PromiseUtils.resolved(true); }

        for (plugin in _plugins) { plugin.destroy(); }

        return this.unload().then(function (value):Bool {
            _animationManager = null;
            _entityManager = null;
            _guiManager = null;
            _inputManager = null;
            _physicsManager = null;
            _sceneManager = null;
            _plugins = new Array<ICorePlugin>();
            _updateablePlugins = new Array<IUpdateable>();
            _loadablePlugins = new Array<ILoadable>();
            _isInitialized = false;

            return true;
        });
	}

    /**
     * Loads all the loadable plugins.
     *
     * @return A promise which is resolved when all the plugins of added to the core have been
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
     * @return A promise which is resolved when all the plugins added to the core have been
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
     * Updates all the plugins.
     *
     * @param elapsedMillis
     *      The time that has passed since the last update.
     */
    public function update(elapsedMillis:Float):Void {
        for (plugin in _updateablePlugins) {
            if (plugin.isEnabled) { plugin.update(elapsedMillis); }
        }
    }
	
    /**
     * Installs the specified plugin in the engine.
     *
     * @param plugin
     *      The plugin which is to be installed.
     *
     * @return A promise which is resolved when the plugin has been installed.
     */
    public function installPlugin(plugin:ICorePlugin):Promise<Bool> {
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
    public function uninstallPlugin(plugin:ICorePlugin):Promise<Bool> {
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
    public function getPluginByName(name:String):ICorePlugin {
        if (name == null || name == "") { return null; }

        for (plugin in _plugins) {
            if (plugin.name == name) { return plugin; }
        }

        return null;
    }

	/**
	 * Gets the first plugin that has the specified type.
	 */
	public function getPluginByType<T:ICorePlugin>(cls:Class<T>):T {
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
	public function getPluginsByType<T:ICorePlugin>(cls:Class<T>):Array<T> {
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
     * Gets whether the core has the specified plugin.
     *
     * @param plugin
     *      The plugin which is to be found.
     *
     * @return True if the core has the plugin and false otherwise.
     */
    public function hasPlugin(plugin:ICorePlugin):Bool {
        return Lambda.has(_plugins, plugin);
    }

    /**
     * Gets whether the core has a plugin with the specified name.
     *
     * @param name
     *      The name of the plugin which is to be found.
     *
     * @return True if the core has the plugin and false otherwise.
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
     * Loads a plugin but only if the plugin is ILoadable and if the core object hasn't been loaded
     * yet.
     *
     * @param plugin
     *      The plugin which is to be unloaded.
     *
     * @return A promise which is resolved when operation is complete.
     */
    private function loadPlugin(plugin:ICorePlugin):Promise<Bool> {
        if (this.isLoaded && Std.is(plugin, ILoadable)) {
            var loadablePlugin:ILoadable = cast plugin;
            return loadablePlugin.load();
        } else {
            return PromiseUtils.resolved(true);
        }
    }

    /**
     * Unloads a plugin but only if the plugin is ILoadable and if the core object has already been
     * loaded.
     *
     * @param plugin
     *      The plugin which is to be unloaded.
     *
     * @return A promise which is resolved when operation is complete.
     */
    private function unloadPlugin(plugin:ICorePlugin):Promise<Bool> {
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
     *      The plugin which is to be added..
     */
    private function addPlugin(plugin:ICorePlugin):Void {
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
    private function removePlugin(plugin:ICorePlugin):Bool {
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

    //}
    //--------------------------------------------------------------------------------------------//

    //--------------------------------------------------------------------------------------------//
    //{ Properties
    //--------------------------------------------------------------------------------------------//

    /**
     * The context where all the visual elements that belong to this core object will be contained.
     */
    public var context(get, never):Context;
    private inline function get_context():Context { return _context; }

    /**
     * The plugin factory used to create the default plugins used by the core.
     */
    public var pluginFactory(get, set):ICorePluginFactory;
    private inline function get_pluginFactory():ICorePluginFactory { return _pluginFactory; }
    private inline function set_pluginFactory(value:ICorePluginFactory):ICorePluginFactory {
        return _pluginFactory = value;
    }

    /**
     * Whether the core has been initialized.
     */
    public var isInitialized(get, never):Bool;
    private inline function get_isInitialized():Bool { return _isInitialized; }

    /**
     * Whether the core has been loaded.
     */
    public var isLoaded(get, never):Bool;
    private inline function get_isLoaded():Bool { return _isLoaded; }

    /**
     * The animation manager.
     */
    public var animationManager(get, never):IAnimationManager;
    private inline function get_animationManager():IAnimationManager { return _animationManager; }

    /**
     * The entity-component manager.
     */
    public var entityManager(get, never):IEntityManager;
    private inline function get_entityManager():IEntityManager { return _entityManager; }

    /**
     * The GUI manager.
     */
    public var guiManager(get, never):IGuiManager;
    private inline function get_guiManager():IGuiManager { return _guiManager; }

    /**
     * The input manager.
     */
    public var inputManager(get, never):IInputManager;
    private inline function get_inputManager():IInputManager { return _inputManager; }

    /**
     * The physics manager.
     */
    public var physicsManager(get, never):IPhysicsManager;
    private inline function get_physicsManager():IPhysicsManager { return _physicsManager; }

    /**
     * The scene manager.
     */
    public var sceneManager(get, never):ISceneManager;
    private inline function get_sceneManager():ISceneManager { return _sceneManager; }

    //}
    //--------------------------------------------------------------------------------------------//

    public static function main():Void {}
}
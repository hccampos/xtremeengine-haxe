package xtremeengine;

import xtremeengine.animation.AnimationManager;
import xtremeengine.animation.IAnimationManager;
import xtremeengine.content.ContentManager;
import xtremeengine.content.IContentManager;
import xtremeengine.entitycomponent.EntityManager;
import xtremeengine.entitycomponent.IEntityManager;
import xtremeengine.errors.Error;
import xtremeengine.gui.GuiManager;
import xtremeengine.gui.IGuiManager;
import xtremeengine.IPlugin;
import xtremeengine.IUpdateable;
import xtremeengine.physics.NapePhysicsManager;
import xtremeengine.physics.IPhysicsManager;
import xtremeengine.scene.ISceneManager;
import xtremeengine.scene.SceneManager;
import flash.events.EventDispatcher;

/**
 * Main class of XtremeEngine. It is responsible for managing all the managers of the engine and
 * making sure that everything fits together.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class Core extends EventDispatcher implements ICore
{
    private var _context:Context;
    private var _contentManager:IContentManager;
	private var _sceneManager:ISceneManager;
	private var _physicsManager:IPhysicsManager;
	private var _entityManager:IEntityManager;
	private var _animationManager:IAnimationManager;
	private var _guiManager:IGuiManager;
	private var _plugins:Array<IPlugin>;
	private var _updateablePlugins:Array<IUpdateable>;
    private var _loadablePlugins:Array<ILoadable>;
	private var _isInitialized:Bool;
    private var _isLoaded:Bool;
	
    //--------------------------------------------------------------------------------------------//

	/**
	 * Constructor.
     *
     * @param context
     *      The context where all the visual elements that belong to this Core object will be
     *      contained.
	 */
	public function new(context:Context):Void
	{
        super();

        if (context == null) { throw new Error("To create a Core object, a context is required."); }
        _context = context;

        _contentManager = null;
		_sceneManager = null;
		_physicsManager = null;
		_entityManager = null;
		_animationManager = null;
		_guiManager = null;

		_plugins = new Array<IPlugin>();
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
	 */
	public function initialize():Void
	{
        if (_isInitialized) { return; }

        _contentManager = new ContentManager(this, "contentManager");
		_sceneManager = new SceneManager(this, "sceneManager");
		_entityManager = new EntityManager(this, "entityManager");
		_animationManager = new AnimationManager(this, "animationManager");
		_guiManager = new GuiManager(this, "guiManager");
        _physicsManager = new NapePhysicsManager(this, "physicsManager");
		
        this.addPlugin(_contentManager);
		this.addPlugin(_sceneManager);
        this.addPlugin(_physicsManager);
        this.addPlugin(_entityManager);
        this.addPlugin(_animationManager);
        this.addPlugin(_guiManager);

        // Initialize all the plugins.
        for (plugin in _plugins)
        {
            plugin.initialize();
        }

        // Load all the plugins.
        this.load();

        _isInitialized = true;
	}

    /**
	 * Releases any resources that were aquired by the core object.
	 */
	public function destroy():Void
	{
        if (!_isInitialized) { return; }

        // Unload all the plugins.
        this.unload();

        // Destroy all the plugins.
		for (plugin in _plugins)
		{
			plugin.destroy();
		}

        _contentManager = null;
		_sceneManager = null;
		_physicsManager = null;
		_entityManager = null;
		_animationManager = null;
		_guiManager = null;
		_plugins = new Array<IPlugin>();
		_updateablePlugins = new Array<IUpdateable>();
        _loadablePlugins = new Array<ILoadable>();
		
		_isInitialized = false;
	}

    /**
     * Loads all the loadable plugins.
     */
    public function load():Void
    {
        if (_isLoaded) { return; }

        for (loadablePlugin in _loadablePlugins)
        {
            loadablePlugin.load();
        }

        _isLoaded = true;
    }

    /**
     * Unloads all the loadable plugins.
     */
    public function unload():Void
    {
        if (!_isLoaded) { return; }

        for (loadablePlugin in _loadablePlugins)
        {
            loadablePlugin.unload();
        }

        _isLoaded = false;
    }

    /**
     * Updates all the plugins.
     *
     * @param elapsedMillis
     *      The time that has passed since the last update.
     */
    public function update(elapsedMillis:Float):Void
    {
        for (plugin in _updateablePlugins)
        {
            if (plugin.isEnabled) { plugin.update(elapsedMillis); }
        }
    }
	
    /**
     * Installs the specified plugin in the engine.
     *
     * @param plugin
     *      The plugin which is to be installed.
     */
    public function installPlugin(plugin:IPlugin):Void
    {
        if (plugin == null) { throw new Error("Intalling null plugin."); }
        this.addPlugin(plugin);
        if (this.isInitialized) { plugin.initialize(); }

        if (this.isLoaded && Std.is(plugin, ILoadable))
        {
            var loadablePlugin:ILoadable = cast plugin;
            loadablePlugin.load();
        }
    }

    /**
     * Uninstalls the specified plugin from the engine.
     *
     * @param plugin
     *      The plugin which is to be uninstalled.
     */
    public function uninstallPlugin(plugin:IPlugin):Void
    {
        if (plugin == null) { throw new Error("Uninstalling null plugin."); }

        if (this.isLoaded && Std.is(plugin, ILoadable))
        {
            var loadablePlugin:ILoadable = cast plugin;
            loadablePlugin.unload();
        }

        plugin.destroy();

        this.removePlugin(plugin);
    }

	/**
	 * Gets the plugin with the specified name. If no name is specified the returned plug-in will be
	 * the first one to match (same type, subclass, implements interface, etc) the specified type
	 * parameter T.
	 */
	public function getPlugin<T: IPlugin>(?name:String, cls:Class<T>):T
	{
        for (plugin in _plugins)
        {
            var nameMatches:Bool = name == null ? true : plugin.name == name;
            if (Std.is(plugin, cls) && nameMatches)
            {
                var ret:T = cast plugin;
                return ret;
            }
        }

        return null;
	}
	
    /**
     * Gets the plugin with the specified name.
     *
     * @param name
     *      The name of the plugin which is to be retrieved.
     *
     * @return The plugin which has the specified name.0
     */
    public function getPluginByName(name:String):IPlugin
    {
        for (plugin in _plugins)
        {
            if (plugin.name == name) { return plugin; }
        }

        return null;
    }

    //}
    //--------------------------------------------------------------------------------------------//

    //--------------------------------------------------------------------------------------------//
    //{ Private Methods
    //--------------------------------------------------------------------------------------------//

    /**
     * Adds a plugin to the engine.
     *
     * @param plugin
     *      The plugin which is to be added to the engine.
     */
    private function addPlugin(plugin:IPlugin):Void
    {
        _plugins.push(plugin);

        if (Std.is(plugin, IUpdateable))
        {
            var updateablePlugin:IUpdateable = cast plugin;
            _updateablePlugins.push(updateablePlugin);
            _updateablePlugins.sort(function (a:IUpdateable, b:IUpdateable) {
                if (a.updateOrder == b.updateOrder) { return 0; }
                return a.updateOrder > b.updateOrder ? 1 : -1;
            });
        }

        if (Std.is(plugin, ILoadable))
        {
            var loadablePlugin:ILoadable = cast plugin;
            _loadablePlugins.push(loadablePlugin);
        }
    }

    /**
     * Removes the specified plugin from the engine.
     *
     * @param plugin
     *      The plugin which is to be removed.
     *
     * @return True if the plugin was removed and false otherwise.
     */
    private function removePlugin(plugin:IPlugin):Bool
    {
        if (plugin == null) { return false; }
        if (!_plugins.remove(plugin)) { return false; }

        if (Std.is(plugin, IUpdateable))
        {
            var updateablePlugin:IUpdateable = cast plugin;
            _updateablePlugins.remove(updateablePlugin);
        }

        if (Std.is(plugin, ILoadable))
        {
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
     * Whether the engine has been initialized.
     */
    public var isInitialized(get, never):Bool;
    private inline function get_isInitialized():Bool { return _isInitialized; }

    /**
     * Whether the object is loaded.
     */
    public var isLoaded(get, never):Bool;
    private inline function get_isLoaded():Bool { return _isLoaded; }

    /**
     * The content manager.
     */
    public var contentManager(get, never):IContentManager;
    private inline function get_contentManager():IContentManager { return _contentManager; }

    /**
     * The scene manager.
     */
    public var sceneManager(get, never):ISceneManager;
    private inline function get_sceneManager():ISceneManager { return _sceneManager; }

    /**
     * The physics manager.
     */
    public var physicsManager(get, never):IPhysicsManager;
    private inline function get_physicsManager():IPhysicsManager { return _physicsManager; }

    /**
     * The entity-component manager.
     */
    public var entityManager(get, never):IEntityManager;
    private inline function get_entityManager():IEntityManager { return _entityManager; }

    /**
     * The animation manager.
     */
    public var animationManager(get, never):IAnimationManager;
    private inline function get_animationManager():IAnimationManager { return _animationManager; }

    /**
     * The GUI manager.
     */
    public var guiManager(get, never):IGuiManager;
    private inline function get_guiManager():IGuiManager { return _guiManager; }

    //}
    //--------------------------------------------------------------------------------------------//

    public static function main():Void
    {
    }
}
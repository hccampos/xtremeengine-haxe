package xtremeengine;

import promhx.Promise;
import xtremeengine.animation.IAnimationManager;
import xtremeengine.content.IContentManager;
import xtremeengine.entitycomponent.IEntityManager;
import xtremeengine.gui.IGuiManager;
import xtremeengine.input.IInputManager;
import xtremeengine.physics.IPhysicsManager;
import xtremeengine.scene.ISceneManager;

/**
 * Interface which defines an XtremeEngine core object. A core object is usually associated with a
 * game screen and makes use of several plugins like a scene manager to define the current scene,
 * an entity-component manager to manager entities and their components, a physics manager to add
 * physics simulation to the scene, etc.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface ICore extends IGameObject extends IAsyncInitializable extends ILoadable {
    /**
     * Updates all the plugins.
     *
     * @param elapsedMillis
     *      The time that has passed since the last update.
     */
    public function update(elapsedMillis:Float):Void;
	
    /**
     * Installs the specified plugin.
     *
     * @param plugin
     *      The plugin which is to be installed.
     *
     * @return A promise which is resolved when the plugin has been installed.
     */
    public function installPlugin(plugin:ICorePlugin):Promise<Bool>;

    /**
     * Uninstalls the specified plugin.
     *
     * @param plugin
     *      The plugin which is to be uninstalled.
     *
     * @return A promise which is resolved when the plugin has been uninstalled.
     */
    public function uninstallPlugin(plugin:ICorePlugin):Promise<Bool>;

    /**
     * Gets the plugin with the specified name.
     *
     * @param name
     *      The name of the plugin which is to be retrieved.
     *
     * @return The plugin which has the specified name.
     */
    public function getPluginByName(name:String):ICorePlugin;

	/**
	 * Gets the first plugin that has the specified type.
	 */
	public function getPluginByType<T:ICorePlugin>(cls:Class<T>):T;

    /**
	 * Gets an array with all the plugins of the specified type.
	 */
	public function getPluginsByType<T:ICorePlugin>(cls:Class<T>):Array<T>;

    /**
     * Gets whether the core has the specified plugin.
     *
     * @param plugin
     *      The plugin which is to be found.
     *
     * @return True if the core has the plugin and false otherwise.
     */
    public function hasPlugin(plugin:ICorePlugin):Bool;

    /**
     * Gets whether the core has a plugin with the specified name.
     *
     * @param name
     *      The name of the plugin which is to be found.
     *
     * @return True if the core has the plugin and false otherwise.
     */
    public function hasPluginNamed(name:String):Bool;

    //--------------------------------------------------------------------------------------------//

    /**
     * The context where all the visual elements that belong to this core object will be contained.
     */
    public var context(get, never):Context;

    /**
     * The plugin factory used to create the default plugins used by the core.
     */
    public var pluginFactory(get, set):ICorePluginFactory;

    /**
     * The animation manager.
     */
    public var animationManager(get, never):IAnimationManager;

    /**
     * The entity-component manager.
     */
    public var entityManager(get, never):IEntityManager;

    /**
     * The GUI manager.
     */
    public var guiManager(get, never):IGuiManager;

    /**
     * The input manager.
     */
    public var inputManager(get, never):IInputManager;

    /**
     * The physics manager.
     */
    public var physicsManager(get, never):IPhysicsManager;

     /**
     * The scene manager.
     */
    public var sceneManager(get, never):ISceneManager;
}
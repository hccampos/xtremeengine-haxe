package xtremeengine;

import xtremeengine.animation.IAnimationManager;
import xtremeengine.content.IContentManager;
import xtremeengine.entitycomponent.IEntityManager;
import xtremeengine.gui.IGuiManager;
import xtremeengine.physics.IPhysicsManager;
import xtremeengine.scene.ISceneManager;

/**
 * Interface which defines an XtremeEngine core object. A core object is responsible for managing
 * all the plugins of the engine and making sure everything fits together nicely.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface ICore extends IInitializable extends ILoadable
{
    /**
     * Updates all the plugins.
     *
     * @param elapsedMillis
     *      The time that has passed since the last update.
     */
    public function update(elapsedMillis:Float):Void;
	
    /**
     * Installs the specified plugin in the engine.
     *
     * @param plugin
     *      The plugin which is to be installed.
     */
    public function installPlugin(plugin:IPlugin):Void;

    /**
     * Uninstalls the specified plugin from the engine.
     *
     * @param plugin
     *      The plugin which is to be uninstalled.
     */
    public function uninstallPlugin(plugin:IPlugin):Void;

	/**
	 * Gets the plugin with the specified name. If no name is specified the returned plug-in will be
	 * the first one to match (same type, subclass, implements interface, etc) the specified type
	 * parameter T.
	 */
	public function getPlugin<T: IPlugin>(?name:String, cls:Class<T>):T;
	
    /**
     * Gets the plugin with the specified name.
     *
     * @param name
     *      The name of the plugin which is to be retrieved.
     *
     * @return The plugin which has the specified name.0
     */
    public function getPluginByName(name:String):IPlugin;

    /**
     * The context where all the visual elements that belong to this core object will be contained.
     */
    public var context(get, never):Context;

    /**
     * The content manager.
     */
    public var contentManager(get, never):IContentManager;

    /**
     * The scene manager.
     */
    public var sceneManager(get, never):ISceneManager;

    /**
     * The physics manager.
     */
    public var physicsManager(get, never):IPhysicsManager;

    /**
     * The entity-component manager.
     */
    public var entityManager(get, never):IEntityManager;

    /**
     * The animation manager.
     */
    public var animationManager(get, never):IAnimationManager;

    /**
     * The GUI manager.
     */
    public var guiManager(get, never):IGuiManager;
}
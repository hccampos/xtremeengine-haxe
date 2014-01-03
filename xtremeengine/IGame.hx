package xtremeengine;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import msignal.Signal.Signal0;
import msignal.Signal.Signal2;
import promhx.Promise;
import xtremeengine.content.IContentManager;
import xtremeengine.screens.IScreenManager;

/**
 * Interface which defines an XtremeEngine game. A game uses plugins like a screen manager to manage
 * game states, a content manager to load assets, etc. It also gives access to the screen/window
 * dimensions and dispatches signals when certain events occur.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IGame extends IAsyncInitializable extends ILoadable {
    /**
     * Installs the specified plugin.
     *
     * @param plugin
     *      The plugin which is to be installed.
     *
     * @return A promise which is resolved when the plugin has been installed.
     */
    public function installPlugin(plugin:IGamePlugin):Promise<Bool>;

    /**
     * Uninstalls the specified plugin.
     *
     * @param plugin
     *      The plugin which is to be uninstalled.
     *
     * @return A promise which is resolved when the plugin has been uninstalled.
     */
    public function uninstallPlugin(plugin:IGamePlugin):Promise<Bool>;

    /**
     * Gets the plugin with the specified name.
     *
     * @param name
     *      The name of the plugin which is to be retrieved.
     *
     * @return The plugin which has the specified name.
     */
    public function getPluginByName(name:String):IGamePlugin;

	/**
	 * Gets the first plugin that has the specified type.
	 */
	public function getPluginByType<T:IGamePlugin>(cls:Class<T>):T;

    /**
	 * Gets an array with all the plugins of the specified type.
	 */
	public function getPluginsByType<T:IGamePlugin>(cls:Class<T>):Array<T>;

    /**
     * Gets whether the game has the specified plugin.
     *
     * @param plugin
     *      The plugin which is to be found.
     *
     * @return True if the game has the plugin and false otherwise.
     */
    public function hasPlugin(plugin:IGamePlugin):Bool;

    /**
     * Gets whether the game has a plugin with the specified name.
     *
     * @param name
     *      The name of the plugin which is to be found.
     *
     * @return True if the game has the plugin and false otherwise.
     */
    public function hasPluginNamed(name:String):Bool;

    //--------------------------------------------------------------------------------------------//

    /**
     * The context where the game is to be displayed.
     */
    public var context(get, never):Context;

    /**
     * The plugin factory used to create the default plugins used by the game.
     */
    public var pluginFactory(get, set):IGamePluginFactory;

    /**
     * The content manager.
     */
    public var contentManager(get, never):IContentManager;

    /**
     * The screen manager of the game.
     */
    public var screenManager(get, never):IScreenManager;

    /**
     * The width of the game screen/window.
     */
    public var width(get, never):Float;

    /**
     * The height of the game screen/window.
     */
    public var height(get, never):Float;

    /**
     * The target frame rate.
     */
    public var targetFps(get, set):Int;

    /**
     * The scale mode of the stage.
     */
    public var scaleMode(get, set):StageScaleMode;

    /**
     * The align mode of the stage.
     */
    public var align(get, set):StageAlign;

    /**
     * Whether the game has a valid context that is added to the stage.
     */
    public var hasValidContext(get, never):Bool;

    /**
     * Signal which is dispatched when the game is activated.
     */
    public var onActivate(get, never):Signal0;

    /**
     * Signal which is dispatched when the game is deactivated.
     */
    public var onDeactivate(get, never):Signal0;

    /**
     * Signal which is dispatched when the game is resized.
     */
    public var onResize(get, never):Signal2<Float, Float>;
}
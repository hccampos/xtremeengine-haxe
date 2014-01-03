package xtremeengine;

import xtremeengine.content.ContentManager;
import xtremeengine.content.IContentManager;
import xtremeengine.IGamePluginFactory;
import xtremeengine.screens.IScreenManager;
import xtremeengine.screens.ScreenManager;

/**
 * Default implementation of the IGamePluginFactory interface. Subclasses can override the methods
 * of the factory in order to customize the plugin creation process and instantiate custom plugins.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class GamePluginFactory implements IGamePluginFactory {
    public function new() { }

    public function createContentManager(game:IGame, name:String):IContentManager {
        return new ContentManager(game, name);
    }

    public function createScreenManager(game:IGame, name:String):IScreenManager {
        return new ScreenManager(game, name);
    }
}
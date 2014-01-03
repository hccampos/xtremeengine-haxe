package xtremeengine;

import xtremeengine.content.IContentManager;
import xtremeengine.screens.IScreenManager;

/**
 * Interface which must be implemented by game plugin factories.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IGamePluginFactory {
    public function createContentManager(game:IGame, name:String):IContentManager;

    public function createScreenManager(game:IGame, name:String):IScreenManager;
}
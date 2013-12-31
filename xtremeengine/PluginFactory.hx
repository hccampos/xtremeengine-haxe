package xtremeengine;

import xtremeengine.animation.AnimationManager;
import xtremeengine.animation.IAnimationManager;
import xtremeengine.content.ContentManager;
import xtremeengine.content.IContentManager;
import xtremeengine.entitycomponent.EntityManager;
import xtremeengine.entitycomponent.IEntityManager;
import xtremeengine.gui.GuiManager;
import xtremeengine.gui.IGuiManager;
import xtremeengine.input.IInputManager;
import xtremeengine.input.InputManager;
import xtremeengine.IPluginFactory;
import xtremeengine.physics.IPhysicsManager;
import xtremeengine.physics.NapePhysicsManager;
import xtremeengine.scene.ISceneManager;
import xtremeengine.scene.SceneManager;

/**
 * Default implementation of the IPluginFactory interface. Subclasses can override the methods of
 * the factory in order to customize the plugin creation process and instantiate custom plugins.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class PluginFactory implements IPluginFactory {
    public function new() { }

    public function createAnimationManager(core:ICore, name:String):IAnimationManager {
        return new AnimationManager(core, name);
    }

    public function createContentManager(core:ICore, name:String):IContentManager {
        return new ContentManager(core, name);
    }

    public function createEntityManager(core:ICore, name:String):IEntityManager {
        return new EntityManager(core, name);
    }

    public function createGuiManager(core:ICore, name:String):IGuiManager {
        return new GuiManager(core, name);
    }

    public function createInputManager(core:ICore, name:String):IInputManager {
        return new InputManager(core, name);
    }

    public function createPhysicsManager(core:ICore, name:String):IPhysicsManager {
        return new NapePhysicsManager(core, name);
    }

    public function createSceneManager(core:ICore, name:String):ISceneManager {
        return new SceneManager(core, name);
    }
}
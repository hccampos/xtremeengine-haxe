package xtremeengine;

import xtremeengine.animation.IAnimationManager;
import xtremeengine.content.IContentManager;
import xtremeengine.entitycomponent.IEntityManager;
import xtremeengine.gui.IGuiManager;
import xtremeengine.input.IInputManager;
import xtremeengine.physics.IPhysicsManager;
import xtremeengine.scene.ISceneManager;

/**
 * Interface which must be implemented by plugin factories.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IPluginFactory {
    public function createAnimationManager(core:ICore, name:String):IAnimationManager;

    public function createContentManager(core:ICore, name:String):IContentManager;

    public function createEntityManager(core:ICore, name:String):IEntityManager;

    public function createGuiManager(core:ICore, name:String):IGuiManager;

    public function createInputManager(core:ICore, name:String):IInputManager;

    public function createPhysicsManager(core:ICore, name:String):IPhysicsManager;

    public function createSceneManager(core:ICore, name:String):ISceneManager;
}
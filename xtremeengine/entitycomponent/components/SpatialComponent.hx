package xtremeengine.entitycomponent.components;

import xtremeengine.entitycomponent.EntityComponent;
import xtremeengine.ICore;
import xtremeengine.scene.SceneNode;

/**
 * Default implementation of the ISpatialComponent interface.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class SpatialComponent extends EntityComponent implements ISpatialComponent
{
    private var _sceneNode:SceneNode;

    /**
     * Initializes a new spatial component instance.
     *
     * @param core
     *      The core object to which the component belongs.
     * @param name
     *      The name of the component.
     */
    public function new(core:ICore, name:String):Void
    {
        super(core, name);

        _sceneNode = new SceneNode(core);
    }

    /**
	 * Called when the component is added to an entity.
	 */
    public override function onAdd():Void
    {
        super.onAdd();
        this.core.sceneManager.rootSceneNode.addChild(_sceneNode);
    }

    /**
	 * Called when the component is removed from an entity.
	 */
    public override function onRemove():Void
    {
        this.core.sceneManager.rootSceneNode.removeChild(_sceneNode);
        super.onRemove();
    }

    /**
     * The scene node which contains the position, rotation and scale of an entity.
     */
    public var sceneNode(get, never):SceneNode;
    private inline function get_sceneNode():SceneNode { return _sceneNode; }
}
package xtremeengine.entitycomponent.components;

import xtremeengine.entitycomponent.EntityComponent;
import xtremeengine.ICore;
import xtremeengine.scene.ISceneManager;
import xtremeengine.scene.ISceneNode;

/**
 * Default implementation of the ISpatialComponent interface.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class SpatialComponent extends EntityComponent implements ISpatialComponent {
    private var _sceneNode:ISceneNode;

    /**
     * Constructor.
     *
     * @param core
     *      The core object to which the object belongs.
     * @param name
     *      The name of the component.
     */
    public function new(core:ICore, name:String):Void {
        super(core, name);
    }

    /**
	 * Called when the component is added to an entity.
	 */
    public override function onAdd():Void {
        super.onAdd();

        if (_sceneNode != null) { _sceneNode.remove(); }

        _sceneNode = this.core.sceneManager.createSceneNode();
        this.core.sceneManager.rootSceneNode.addChild(_sceneNode);
    }

    /**
	 * Called when the component is removed from an entity.
	 */
    public override function onRemove():Void {
        super.onRemove();

        if (_sceneNode != null) { _sceneNode.remove(); }
    }

    /**
     * The scene node which contains the position, rotation and scale of an entity.
     */
    public var sceneNode(get, never):ISceneNode;
    private inline function get_sceneNode():ISceneNode { return _sceneNode; }
}
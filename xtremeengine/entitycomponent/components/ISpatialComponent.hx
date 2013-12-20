package xtremeengine.entitycomponent.components;

import xtremeengine.entitycomponent.IEntityComponent;
import xtremeengine.scene.SceneNode;

/**
 * Interface which defines a spatial component.
 *
 * A spatial component provides
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface ISpatialComponent extends IEntityComponent
{
    /**
     * The scene node which contains the position, rotation and scale of an entity.
     */
    public var sceneNode(get, never):SceneNode;
}
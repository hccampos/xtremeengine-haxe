package xtremeengine.scene;
import xtremeengine.Context;

/**
 * Interface which defines a scene node.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface ISceneNode extends IPositionable extends IRotateable extends IScalable {
    /**
     * Creates a new scene node and adds it as a child of this node.
     *
     * @return The new scene node.
     */
    public function createChild():ISceneNode;

    /**
     * Adds the specified scene node as a child of this scene node.
     *
     * @param child
     *      The scene node which is to be added.
     */
    public function addChild(child:ISceneNode):Void;

    /**
     * Removes the specified scene node from this scene node.
     *
     * @param child
     *      The scene node which is to be removed.
     *
     * @return True if the scene node was removed and false otherwise.
     */
    public function removeChild(child:ISceneNode):Bool;

    /**
     * Removes all the descendants of the scene node.
     */
    public function removeDescendants():Void;

    /**
     * Removes the scene node from its parent.
     *
     * @return True if the scene node was removed and false otherwise.
     */
    public function remove():Bool;

    /**
     * Gets whether the specified scene node is a child of this scene node.
     *
     * @param child
     *      The scene node which is to be checked.
     *
     * @return True if the specified scene node is a child of this scene node and false otherwise.
     */
    public function contains(child:ISceneNode):Bool;

    /**
     * The scene manager to which the node belongs.
     */
    public var sceneManager(get, never):ISceneManager;

    /**
     * The context which is associated with the scene node.
     */
    public var context(get, never):Context;

    /**
     * The parent of this scene node.
     */
    public var parent(get, never):ISceneNode;

    /**
     * The children of the node.
     */
    public var children(get, never):Array<ISceneNode>;

    /**
     * Whether the node is a root scene node (i.e. has no parent).
     */
    public var isRoot(get, never):Bool;
}
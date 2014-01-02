package xtremeengine.scene;

import xtremeengine.errors.Error;
import xtremeengine.Context;
import xtremeengine.utils.MathUtils;
import xtremeengine.utils.Vec2;

/**
 * A scene node is the basic component of a scene. By adding scene nodes to other scene nodes, one
 * can create an entire scene graph to represent the scene.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class SceneNode implements ISceneNode {
    private var _sceneManager:ISceneManager;
    private var _parent:ISceneNode;
    private var _children:Array<ISceneNode>;
    private var _context:Context;

    //--------------------------------------------------------------------------------------------//

    /**
     * Initializes a new scene node.
     *
     * @param sceneManager
     *      The scene manager to which the node belongs.
     * @param context
     *      The context which is to be wrapped by the scene node.
     */
    public function new(sceneManager:ISceneManager, ?context:Context):Void {
        _sceneManager = sceneManager;
        _parent = null;
        _children = new Array<ISceneNode>();
        _context = context == null ? new Context() : context;
    }


    //--------------------------------------------------------------------------------------------//
    //{ Public Methods
    //--------------------------------------------------------------------------------------------//

    /**
     * Creates a new scene node and adds it as a child of this node.
     *
     * @return The new scene node.
     */
    public function createChild():ISceneNode {
        var newNode:ISceneNode = this.sceneManager.createSceneNode();
        this.addChild(newNode);
        return newNode;
    }

    /**
     * Adds the specified scene node as a child of this scene node.
     *
     * @param child
     *      The scene node which is to be added.
     */
    public function addChild(child:ISceneNode):Void {
        // Make sure the scene manager of the child is the same as our scene manager. This way we
        // ensure that scene nodes belonging to different scene managers are not mixed.
        if (child.sceneManager != this.sceneManager) {
            throw new Error("Cannot add a child that belongs to another scene node.");
        }

        // Make sure the child is a SceneNode because we need to access the context and parent of
        // the child.
        if (!Std.is(child, SceneNode)) {
            throw new Error("Cannot add a child that has a different concrete type.");
        }

        // If the child already has a parent we have to remove it from that parent.
        if (child.parent != null && child.parent != this) { child.remove(); }
        // If this node already has the child node, there's nothing to do.
        if (this.contains(child)) { return; }

        _children.push(child);

        // Configure the internals of the child.
        var childNode:SceneNode = cast child;
        _context.addChild(childNode._context);
        childNode._parent = this;
    }

    /**
     * Removes the specified scene node from this scene node.
     *
     * @param child
     *      The scene node which is to be removed.
     *
     * @return True if the scene node was removed and false otherwise.
     */
    public function removeChild(child:ISceneNode):Bool {
        if (child.parent != this) { return false; }

        var result:Bool = _children.remove(child);
        if (!result) { return false; }

        // Access the private attributes of the child scene node.
        var childNode:SceneNode = cast child;
        _context.removeChild(childNode._context);
        childNode._parent = null;

        return true;
    }

    /**
     * Removes all the descendants of the scene node.
     */
    public function removeDescendants():Void {
        var child:SceneNode = null;

        while ((child = cast _children.pop()) != null) {
            child.removeDescendants();
            _context.removeChild(child._context);
            child._parent = null;
        }
    }

    /**
     * Removes the scene node from its parent.
     *
     * @return True if the scene node was removed and false otherwise.
     */
    public function remove():Bool {
        if (_parent == null) { return false; }

        var result:Bool = _parent.removeChild(this);
        _parent = null;

        return result;
    }

    /**
     * Gets whether the specified scene node is a child of this scene node.
     *
     * @param child
     *      The scene node which is to be checked.
     *
     * @return True if the specified scene node is a child of this scene node and false otherwise.
     */
    public function contains(child:ISceneNode):Bool {
        if (child == null) { return false; }

        return Lambda.has(_children, child);
    }

    //}
    //--------------------------------------------------------------------------------------------//

    //--------------------------------------------------------------------------------------------//
    //{ Properties
    //--------------------------------------------------------------------------------------------//

    /**
     * The scene manager to which the node belongs.
     */
    public var sceneManager(get, never):ISceneManager;
    private inline function get_sceneManager():ISceneManager { return _sceneManager; }

    /**
     * The context which is associated with the scene node.
     */
    public var context(get, never):Context;
    private inline function get_context():Context { return _context; }

    /**
     * The parent of this scene node.
     */
    public var parent(get, never):ISceneNode;
    private inline function get_parent():ISceneNode { return _parent; }

    /**
     * The children of the node.
     */
    public var children(get, never):Array<ISceneNode>;
    private inline function get_children():Array<ISceneNode> { return _children; }

    /**
	 * The position of the scene node.
	 */
	public var position(get, set):Vec2;
	private inline function get_position():Vec2 { return new Vec2(_context.x, _context.y); }
	private inline function set_position(value:Vec2):Vec2 {
        if (value != null) {
            _context.x = value.x;
            _context.y = value.y;
        }

        return this.scale;
    }
	
    /**
     * The position along the X axis.
     */
    public var x(get, set):Float;
    private inline function get_x():Float { return _context.x; }
    private inline function set_x(value:Float):Float { return _context.x = value; }

    /**
     * The position along the Y axis.
     */
    public var y(get, set):Float;
    private inline function get_y():Float { return _context.y; }
    private inline function set_y(value:Float):Float { return _context.y = value; }

	/**
	 * The scale of the scene node.
	 */
	public var scale(get, set):Vec2;
	private inline function get_scale():Vec2 { return new Vec2(_context.x, _context.y); }
	private inline function set_scale(value:Vec2):Vec2 {
        if (value != null) {
            _context.scaleX = value.x;
            _context.scaleY = value.y;
        }

        return this.scale;
    }
	
    /**
     * The scale along the X axis.
     */
    public var scaleX(get, set):Float;
    private inline function get_scaleX():Float { return _context.scaleX; }
    private inline function set_scaleX(value:Float):Float { return _context.scaleX = value; }

    /**
     * The scale along the Y axis.
     */
    public var scaleY(get, set):Float;
    private inline function get_scaleY():Float { return _context.scaleY; }
    private inline function set_scaleY(value:Float):Float { return _context.scaleY = value; }

	/**
	 * The rotation of the scene node (in radians).
	 */
	public var rotation(get, set):Float;
	private inline function get_rotation():Float { return MathUtils.toRadians(_context.rotation); }
	private inline function set_rotation(value:Float):Float {
        return _context.rotation = MathUtils.toDegrees(value);
    }

    /**
     * Whether the node is a root scene node (i.e. has no parent).
     */
    public var isRoot(get, never):Bool;
    private inline function get_isRoot():Bool { return _parent == null; }

    //}
    //--------------------------------------------------------------------------------------------//
}
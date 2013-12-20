package xtremeengine.scene;

import xtremeengine.Context;
import xtremeengine.CoreObject;
import xtremeengine.ICore;
import xtremeengine.utils.MathUtils;
import xtremeengine.utils.Vec2;

/**
 * A scene node is the basic component of a scene. By adding scene nodes to other scene nodes, one
 * can create an entire scene graph to represent the scene.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class SceneNode extends CoreObject implements IPositionable
                             implements IRotateable
                             implements IScalable
{
    private var _parent:SceneNode;
    private var _parentContext:Context;
    private var _context:Context;

    //--------------------------------------------------------------------------------------------//

    /**
     * Initializes a new scene node.
     *
     * @param core
     *      The core object to which the scene node belongs.
     */
    public function new(core:ICore):Void
    {
        super(core);

        _parent = null;
        _parentContext = null;
        _context = new Context();
    }


    //--------------------------------------------------------------------------------------------//
    //{ Public Methods
    //--------------------------------------------------------------------------------------------//

    /**
     * Adds the specified scene node as a child of this scene node.
     *
     * @param child
     *      The scene node which is to be added.
     */
    public function addChild(child:SceneNode):Void
    {
        // If the child already has a parent we have to remove it from that parent.
        if (child.parent != null && child.parent != this) { child.remove(); }
        // If this node already has the child node, there's nothing to do.
        if (this.contains(child)) { return; }

        _context.addChild(child._context);
        child._parent = this;
    }

    /**
     * Removes the specified scene node from this scene node.
     *
     * @param child
     *      The scene node which is to be removed.
     *
     * @return True if the scene node was removed and false otherwise.
     */
    public function removeChild(child:SceneNode):Bool
    {
        if (child.parent != this || !this.contains(child)) { return false; }

        _context.removeChild(child._context);
        child._parent = null;

        return true;
    }

    /**
     * Removes the scene node from its parent.
     *
     * @return True if the scene node was removed and false otherwise.
     */
    public function remove():Bool
    {
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
    public function contains(child:SceneNode):Bool
    {
        if (child == null) { return false; }
        return _context.contains(child._context);
    }

    /**
     * Adds the scene node to the specified context.
     */
    public function addToContext(context:Context):Void
    {
        _parentContext = context;
        _parentContext.addChild(_context);
    }

    /**
     * Removes the scene node from the parent context.
     *
     * @return True if the scene node was removed and false otherwise.
     */
    public function removeFromContext():Bool
    {
        if (_parentContext == null) { return false; }
        if (!_parentContext.contains(_context)) { return false; }

        _parentContext.removeChild(_context);
        _parentContext = null;

        return true;
    }

    //}
    //--------------------------------------------------------------------------------------------//

    //--------------------------------------------------------------------------------------------//
    //{ Properties
    //--------------------------------------------------------------------------------------------//

    /**
     * The parent of this scene node.
     */
    public var parent(get, never):SceneNode;
    private inline function get_parent():SceneNode { return _parent; }

    /**
	 * The position of the scene node.
	 */
	public var position(get, set):Vec2;
	private inline function get_position():Vec2 { return new Vec2(_context.x, _context.y); }
	private inline function set_position(value:Vec2):Vec2
    {
        if (value != null)
        {
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
	private inline function set_scale(value:Vec2):Vec2
    {
        if (value != null)
        {
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
	private inline function set_rotation(value:Float):Float { return _context.rotation = MathUtils.toDegrees(value); }

    /**
     * Whether the node is a root scene node (i.e. has no parent).
     */
    public var isRoot(get, never):Bool;
    private inline function get_isRoot():Bool { return _parent == null; }

    //}
    //--------------------------------------------------------------------------------------------//
}
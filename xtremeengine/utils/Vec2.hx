package xtremeengine.utils;

/**
 * Simple 2D vector class.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class Vec2
{
	public var x:Float;
	public var y:Float;
	
    /**
     * Initializes a new vector.
     *
     * @param x
     *      The x coordinate.
     * @param y
     *      The y coordinate.
     */
	public function new(x:Float = 0.0, y:Float = 0.0):Void
	{
		this.x = x;
		this.y = y;
	}
	
    /**
     * Creates a copy of the vector.
     *
     * @return A new 2D vector with the same coordinates as the current vector.
     */
	public function clone():Vec2 {
		return new Vec2(this.x, this.y);
	}
	
    /**
     * Gets whether the current vector is equal to the specified vector.
     *
     * @param other
     *      The vector to which the current vector is to be compared.
     *
     * @return True if the vectors are equal and false otherwise.
     */
    public function equals(other):Bool
    {
        return this.x == other.x && this.y == other.y;
    }

    /**
     * Adds the specified vector to the current vector.
     *
     * @param other
     *      The vector which is to be added to the current vector.
     *
     * @return A reference to the current vector.
     */
	public function add(other:Vec2):Vec2 {
		this.x += other.x;
		this.y += other.y;
		return this;
	}
	
    /**
     * Gets the result of adding the specified vector to the current vector. The current vector is
     * left unchanged.
     *
     * @param other
     *      The vector which is to be added to the current vector.
     *
     * @return A new vector which is the result of adding the specified vector to the current
     * vector.
     */
	public function plus(other:Vec2):Vec2 {
		return this.clone().add(other);
	}
	
    /**
     * Subtracts the specified vector from the current vector.
     *
     * @param other
     *      The vector which is to be subtracted from the current vector.
     *
     * @return A reference to the current vector.
     */
	public function sub(other:Vec2):Vec2 {
		this.x -= other.x;
		this.y -= other.y;
		return this;
	}
	
    /**
     * Gets the result of subtracting the specified vector from the current vector. The current
     * vector is left unchanged.
     *
     * @param other
     *      The vector which is to be subtracted from the current vector.
     *
     * @return A new vector which is the result of subtracting the specified vector from the current
     * vector.
     */
	public function minus(other:Vec2):Vec2 {
		return this.clone().sub(other);
	}
	
    /**
     * Gets the dot product of the current vector with the specified vector.
     *
     * @param other
     *      The other vector used to calculate the dot product.
     *
     * @return The dot product of the current vector with the specified vector.
     */
	public function dot(other:Vec2):Float {
		return (this.x * other.x) + (this.y * other.y);
	}
	
    /**
     * Scales the current vector by multiplying each coordinate by the specified factor.
     *
     * @param factor
     *      The number by which each coordinate of the current vector is to be multiplied.
     *
     * @return A reference to the current vector.
     */
	public function scale(factor:Float):Vec2 {
		this.x *= factor;
		this.y *= factor;
		return this;
	}
	
    /**
     * Gets the result of scaling the current vector by the specified factor. The current vector is
     * left unchanged.
     *
     * @param factor
     *      The number by which each coordinate of the current vector is to be multiplied.
     *
     * @return A new vector which is the result of scaling the current vector by the specified
     * factor.
     */
	public function scaled(factor:Float):Vec2 {
		return this.clone().scale(factor);
	}
	
    /**
     * Rotates the current vector by the specified angle (in radians).
     *
     * @param radians
     *      The angle (in radians) by which the current vector is to be rotated.
     *
     * @return A reference to the current vector.
     */
	public function rotate(radians:Float):Vec2 {
		var x:Float = this.x;
		var y:Float = this.y;
		var sinTheta:Float = Math.sin(radians);
		var cosTheta:Float = Math.cos(radians);
		
		this.x = x * cosTheta - y * sinTheta;
		this.y = x * sinTheta + y * cosTheta;
		return this;
	}
	
    /**
     * Gets the result of rotating the current vector by the specified angle (in radians). The
     * current vector is left unchanged.
     *
     * @param radians
     *      The angle (in radians) by which the current vector is to be rotated.
     *
     * @return A new vector which is the result of rotating the current vector by the specified
     * angle (in radians).
     */
	public function rotated(radians:Float):Vec2 {
		return this.clone().rotate(radians);
	}
	
    /**
     * Normalizes the current vector.
     *
     * @return A reference to the current vector.
     */
	public function normalize():Vec2 {
		var magnitude = this.magnitude;
		this.x /= magnitude;
		this.y /= magnitude;
		return this;
	}
	
    /**
     * Gets a normalized copy of the current vector. The current vector is left unchanged.
     *
     * @return A normalized copy of the current vector.
     */
	public function normalized():Vec2 {
		return this.clone().normalize();
	}
	
    /**
     * Gets the angle (in radians) between the current vector and the specified vector.
     *
     * @param other
     *      The vector to which the current vector is to be compared.
     *
     * @return The angle (in radians) between the current vector and the specified vector
     */
	public function getAngle(other:Vec2):Float {
		return Math.atan2(other.y - this.y, other.x - this.x);
	}
	
    /**
     * Gets a vector which is perpendicular to the current vector.
     *
     * @param clockwise
     *      The direction in which the current vector is to be rotated (by PI/2, or 90 degrees) to
     *      obtain the perpendicular vector.
     *
     * @return A new vector which is perpendicular to the current vector.
     */
	public function getPerpendicular(clockwise:Bool = false):Vec2 {
		return clockwise ? new Vec2(this.y, -this.x) : new Vec2(-this.y, this.x);
	}
	
    /**
     * Gets the string representation of the vector.
     */
	public function toString():String {
		return "(" + this.x + "," + this.y + ")";
	}

    /**
     * Gets the middle point of the specified list of points.
     *
     * @param points
     *      The points whose middle point is to be calculated.
     *
     * @return A new vector which is the middle point of the specified list of points.
     */
    public static function middlePoint(points:Array<Vec2>):Vec2
    {
        var count:Float = points.length;
        if (count == 0) { return null; }

        var xSum:Float = 0;
        var ySum:Float = 0;

        for (p in points)
        {
            xSum += p.x;
            ySum += p.y;
        }

        return new Vec2(xSum / count, ySum / count);
    }

    /**
     * The magnitude (or length) of the vector.
     */
	public var magnitude(get, never):Float;
	private inline function get_magnitude():Float {
		return Math.sqrt(x * x + y * y);
	}
	
    /**
     * The length (or magnitude) of the vector.
     */
	public var length(get, never):Float;
	private inline function get_length():Float {
		return get_magnitude();
	}
}
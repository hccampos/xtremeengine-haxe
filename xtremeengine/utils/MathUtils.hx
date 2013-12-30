package xtremeengine.utils;

/**
 * Some common mathematical constants.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class MathUtils
{
	public static inline var Pi = 3.1415926535897932384626433832795;
	public static inline var TwoPi = 6.283185307179586476925286766559;
	public static inline var PiOverTwo = 1.5707963267948966192313216916398;
	public static inline var PiOverThree = 1.0471975511965977461542144610932;
	public static inline var PiOverFour = 0.78539816339744830961566084581988;
	public static inline var PiOverFive = 0.6283185307179586476925286766559;
	public static inline var PiOverSix = 0.52359877559829887307710723054658;
	
	public static inline var Euler = 2.718281828459045235360287;
	public static inline var GoldenRatio = 1.618033988749894848204586;
	
	/**
	 * Converts a value from degrees to radians.
	 *
	 * @param degrees
	 * 		The value which is to be converted.
	 *
	 * @return The specified value in radians.
	 */
	public static inline function toRadians(degrees:Float):Float {
		return degrees * 0.01745329251994329576923690768489;
	}
	
	/**
	 * Converts a value from radians to degrees.
	 *
	 * @param radians
	 * 		The value which is to be converted.
	 *
	 * @return The specified value in degrees.
	 */
	public static inline function toDegrees(radians:Float):Float {
		return radians * 57.295779513082320876798154814105;
	}

    /**
     * Clamps the specified value to the specified range [min, max].
     *
     * @param value
     *      The value which is to be clamped.
     * @param min
     *      The minimum allowed value.
     * @param max
     *      The maximum allowed value.
     *
     * @return The clamped value.
     */
    public static inline function clamp(value:Float, min:Float, max:Float):Float
    {
        if (value > max) {
            return max;
        }
        else if (value < min) {
            return min;
        }
        else {
            return value;
        }
    }
}
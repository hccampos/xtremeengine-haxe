package xtremeengine.utils;

/**
 * ...
 * @author Hugo Campos
 */
class Utils
{
	private function new() { }
	
	public static function between(min:Float, max:Float):Float {
		return min + Math.random() * (max - min);
	}
	
	public static function linearInterpolation(t:Float, startValue:Float, endValue:Float, duration:Float):Float {
		return (endValue - startValue) * t / duration + startValue;
	}
}
package xtremeengine.utils;

/**
 * Commonly used utilities.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class Utils
{
	private function new() { }

	public static function between(min:Float, max:Float):Float {
		return min + Math.random() * (max - min);
	}
	
	public static function lerp(t:Float, startValue:Float, endValue:Float, duration:Float):Float {
		return (endValue - startValue) * t / duration + startValue;
	}
}
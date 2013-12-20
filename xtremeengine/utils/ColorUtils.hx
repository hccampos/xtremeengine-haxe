package xtremeengine.utils;

/**
 * Class which contains some methods that are useful for working with colors.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class ColorUtils
{
	private function new() { }
	
	public static function rgbToInt(r:Int, g:Int, b:Int):Int
	{
		return ((r&0x0ff)<<16)|((g&0x0ff)<<8)|(b&0x0ff);
	}
	
	public static inline function extractRed(c:Int):Int { return (( c >> 16 ) & 0xFF); }
	public static inline function extractGreen(c:Int):Int { return ( (c >> 8) & 0xFF ); }
	public static inline function extractBlue(c:Int):Int { return ( c & 0xFF ); }
}
package xtremeengine.animation.easing;

import xtremeengine.animation.IEasingFunction;

/**
 * Out elastic easing function.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class EaseInOutCubic implements IEasingFunction {
    public function new() { }

    /**
     * Function used to ease the animation.
     *
     * @param position
     *      The current position of the animation.
     *
     * @return The eased position of the animation.
     */
    public inline function ease(position:Float):Float {
        var ts:Float = position * position;
        var tc:Float = ts * position;
        return 33 * tc * ts - 106 * ts * ts + 126 * tc - 67 * ts + 15 * position;
    }
}
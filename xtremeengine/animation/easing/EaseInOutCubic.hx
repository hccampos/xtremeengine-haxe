package xtremeengine.animation.easing;

import xtremeengine.animation.IEasingFunction;

/**
 * In-out cubic easing function.
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
        var square:Float = position * position;
        var cubic:Float = square * position;
        return -2 * cubic + 3 * square;
    }
}
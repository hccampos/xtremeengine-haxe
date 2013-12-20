package xtremeengine.animation.interpolators;

import xtremeengine.utils.Vec2;
import xtremeengine.animation.IInterpolator.IInterpolator;

/**
 * Interpolator which interpolates 2D vectors.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class Vec2LerpInterpolator implements IInterpolator<Vec2>
{
    public function new():Void {}

    /**
     * Interpolates values between the specified initialValue and finalValue.
     *
     * @param position
     *      The current position (0: Beginning -> 1: End).
     * @param initialValue
     *      The initial value.
     * @param finalValue
     *      The final value.
     *
     * @return The interpolated value.
     */
    public function interpolate(position:Float, initialValue:Vec2, finalValue:Vec2):Vec2
    {
        var x:Float = initialValue.x + position * (finalValue.x - initialValue.x);
        var y:Float = initialValue.y + position * (finalValue.y - initialValue.y);
        return new Vec2(x, y);
    }
}
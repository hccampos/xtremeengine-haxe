package xtremeengine.animation.interpolators;

import xtremeengine.animation.IInterpolator.IInterpolator;

/**
 * Interpolator which interpolates float values.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class FloatLerpInterpolator implements IInterpolator<Float>
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
    public function interpolate(position:Float, initialValue:Float, finalValue:Float):Float
    {
        return initialValue + position * (finalValue - initialValue);
    }
}
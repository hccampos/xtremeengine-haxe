package xtremeengine.animation;

/**
 * Interface which defines an interpolator.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IInterpolator<T>
{
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
    public function interpolate(position:Float, initialValue:T, finalValue:T):T;
}
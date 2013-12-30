package xtremeengine.animation;

/**
 * Interface which defines an easing function object.
 *
 * An easing function object applies a function to a value in order to ease an animation.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IEasingFunction {
    /**
     * Function used to ease the animation.
     *
     * @param position
     *      The current position of the animation.
     *
     * @return The eased position of the animation.
     */
    public function ease(position:Float):Float;
}
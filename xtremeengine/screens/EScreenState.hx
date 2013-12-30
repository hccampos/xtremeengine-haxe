package xtremeengine.screens;

/**
 * Enum which describes the transition state of a screen.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
enum EScreenState {
    /**
     * The screen is transitioning from hidden to visible.
     */
    TransitionOn;
    /**
     * The screen is visible and active.
     */
    Active;
    /**
     * The screen is transitioning from visible to hidden.
     */
    TransitionOff;
    /**
     * The screen is totally hidden.
     */
    Hidden;
}
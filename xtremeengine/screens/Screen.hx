package xtremeengine.screens;

import promhx.Promise;
import xtremeengine.Context;
import xtremeengine.utils.MathUtils;
import xtremeengine.utils.PromiseUtils;

/**
 * Default implementation of the IScreen interface.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class Screen implements IScreen {
    private static inline var ON_DIR:Float = -1;
    private static inline var OFF_DIR:Float = 1;

    private var _screenManager:IScreenManager;
    private var _context:Context;
    private var _isLoaded:Bool;
    private var _isPopup:Bool;
    private var _transitionOnDuration:Float;
    private var _transitionOffDuration:Float;
    private var _transitionPosition:Float;
    private var _state:EScreenState;
    private var _isExiting:Bool;
    private var _otherScreenHasFocus:Bool;

    //--------------------------------------------------------------------------------------------//

    /**
     * Constructor.
     *
     * @param screenManager
     *      The screen manager to which the screen belongs.
     */
    public function new():Void {
        _screenManager = null;
        _context = new Context();
        _isLoaded = false;
        _isPopup = false;
        _transitionOnDuration = 0.0;
        _transitionOffDuration = 0.0;
        _transitionPosition = 1;
        _state = EScreenState.TransitionOn;
        _isExiting = false;
        _otherScreenHasFocus = false;
    }

    //--------------------------------------------------------------------------------------------//
    //{ Public Methods
    //--------------------------------------------------------------------------------------------//

    /**
     * Loads any required resources.
     */
    public function load():Promise<Bool> {
        _isLoaded = true;
        return PromiseUtils.resolved(true);
    }

    /**
     * Unloads any resources that may have been loaded.
     */
    public function unload():Promise<Bool> {
        _isLoaded = false;
        return PromiseUtils.resolved(true);
    }

    /**
     * Allows the screen to run logic, such as updating the transition position.
     *
     * @param elapsedMillis
     *      The time that has passed since the last update.
     * @param otherScreenHasFocus
     *      Whether another screen has got input focus.
     * @param isCovered
     *      Whether the screen is covered by another screen.
     */
    public function update(elapsedMillis:Float, otherScreenHasFocus:Bool, isCovered:Bool):Void {
        _otherScreenHasFocus = otherScreenHasFocus;

        if (this.isExiting) {
            _state = EScreenState.TransitionOff;
            var done:Bool = this.transition(elapsedMillis, this.transitionOffDuration, OFF_DIR);
            if (done) { this.screenManager.removeScreen(this); }
        } else if (isCovered) {
            var done:Bool = this.transition(elapsedMillis, this.transitionOffDuration, OFF_DIR);
            _state = done ? EScreenState.Hidden : EScreenState.TransitionOff;
        } else {
            var done:Bool = this.transition(elapsedMillis, this.transitionOnDuration, ON_DIR);
            _state = done ? EScreenState.Active : EScreenState.TransitionOn;
        }

        // The screen only has to be visible if it's state is not hidden. This way, we don't bother
        // the CPU and GPU with screens that are hidden.
        this.context.visible = this.state != EScreenState.Hidden;
    }

    /**
     * Allows the screen to handle user input. Unlike the update() method, this method is only
     * called when the screen has focus.
     *
     * @param elapsedMillis
     *      The time that has passed since the last update.
     * @param otherScreenHasFocus
     *      Whether another screen has got input focus.
     * @param isCovered
     *      Whether the screen is covered by another screen.
     */
    public function handleInput(elapsedMillis:Float, otherScreenHasFocus:Bool, isCovered:Bool):Void {}

    /**
     * Tells the screen to go away. Unlike IScreenManager.removeScreen(), which instantly kills the
     * screen, this method respects the transition timings and will give the screen a chance to
     * gradually transition off.
     */
    public function exit():Void {
        if (_transitionOffDuration == 0.0) {
            this.screenManager.removeScreen(this);
        } else {
            _isExiting = true;
        }
    }

    //}
    //--------------------------------------------------------------------------------------------//

    //--------------------------------------------------------------------------------------------//
    //{ Private Methods
    //--------------------------------------------------------------------------------------------//

    /**
     * Helper for updating the screen transition position.
     *
     * @param elapsedMillis
     *      The time that has passed since the last update.
     * @param transitionDuration
     *      The total duration of the transition.
     * @param direction
     *      Whether we're transitioning on or off.
     *
     * @return Whether the transition is finished.
     */
    private function transition(elapsedMillis:Float, transitionDuration:Float, direction:Int):Bool {
        var delta:Float = transitionDuration == 0 ? 1 : (elapsedMillis / transitionDuration);

        _transitionPosition += delta * direction;

        var transitioningOn:Bool = direction < 0;
        var transitioningOff:Bool = direction > 0;
        var fullyOn:Bool = _transitionPosition <= 0;
        var fullyOff:Bool = _transitionPosition >= 1;

        // Are we done transitioning?
        if ((transitioningOn && fullyOn) || (transitioningOff && fullyOff)) {
            // The transition is finished so we return true.
            _transitionPosition = MathUtils.clamp(_transitionPosition, 0, 1);
            return true;
        }

        // We're still transitioning...
        return false;
    }

    //}
    //--------------------------------------------------------------------------------------------//

    //--------------------------------------------------------------------------------------------//
    //{ Properties
    //--------------------------------------------------------------------------------------------//

    /**
     * The screen manager to which the screen belongs.
     */
    public var screenManager(get, set):IScreenManager;
    private inline function get_screenManager():IScreenManager { return _screenManager; }
    private inline function set_screenManager(value:IScreenManager):IScreenManager {
        return _screenManager = value;
    }

    /**
     * The context where the screen is drawn.
     */
    public var context(get, never):Context;
    private inline function get_context():Context { return _context; }

     /**
     * Whether the object is loaded.
     */
    public var isLoaded(get, never):Bool;
    private inline function get_isLoaded():Bool { return _isLoaded; }

    /**
     * Indicates how long the screen takes to transition on when it is activated (in milliseconds).
     */
    public var transitionOnDuration(get, set):Float;
    private inline function get_transitionOnDuration():Float { return _transitionOnDuration; }
    private inline function set_transitionOnDuration(value:Float):Float {
        return _transitionOnDuration = value;
    }

    /**
     * Indicates how long the screen takes to transition off when it is deactivated (in
     * milliseconds).
     */
    public var transitionOffDuration(get, set):Float;
    private inline function get_transitionOffDuration():Float { return _transitionOffDuration; }
    private inline function set_transitionOffDuration(value:Float):Float {
        return _transitionOffDuration = value;
    }

    /**
     * The current position of the screen transition ranging from 0 (fully active, no transition) to
     * 1 (fully transitioned off).
     */
    public var transitionPosition(get, set):Float;
    private inline function get_transitionPosition():Float { return _transitionPosition; }
    private inline function set_transitionPosition(value:Float):Float {
        return _transitionPosition = value;
    }

    /**
     * The current alpha of the screen transition, ranging from 1 (fully active, no transition) to 0
     * (transitioned fully off to nothing).
     */
    public var transitionAlpha(get, never):Float;
    private inline function get_transitionAlpha():Float { return 1.0 - _transitionPosition; }

    /**
     * The current transition state.
     */
    public var state(get, set):EScreenState;
    private inline function get_state():EScreenState { return _state; }
    private inline function set_state(value:EScreenState):EScreenState { return _state = value; }

    /**
     * Normally when one screen is brought up over the top of another, the first screen will
     * transition off to make room for the new one. This property indicates whether the screen is
     * only a popup, in which case screens underneath it do not need to bother transitioning off.
     */
    public var isPopup(get, set):Bool;
    private inline function get_isPopup():Bool { return _isPopup; }
    private inline function set_isPopup(value:Bool):Bool { return _isPopup = value; }

    /**
     * There are two possible reasons why a screen might be transitioning off. It could be
     * temporarily going away to make room for another screen that is on top of it, or it could be
     * going away for good. This property indicates whether the screen is exiting for good: if set,
     * the screen will automatically remove itself as soon as the transition finishes.
     */
    public var isExiting(get, never):Bool;
    private inline function get_isExiting():Bool { return _isExiting; }

    /**
     * Whether this screen is active and can respond to user input.
     */
    public var isActive(get, never):Bool;
    private inline function get_isActive():Bool
    {
        return !_otherScreenHasFocus &&
               (_state == EScreenState.TransitionOn || _state == EScreenState.Active);
    }

    //}
    //--------------------------------------------------------------------------------------------//
}
package xtremeengine.screens;

import xtremeengine.CoreObject;
import xtremeengine.Core;
import xtremeengine.utils.MathUtils;

/**
 * Default implementation of the IScreen interface.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class Screen implements IScreen
{
    private var _screenManager:IScreenManager;
    private var _isInitialized:Bool;
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
    public new(screenManager:IScreenManager):Void
    {
        _screenManager = screenManager;
        _isInitialized = false;
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
	 * Initializes the screen.
	 */
	public function initialize():Void
    {
        if (_isInitialized) { return; }
        _isInitialized = true;
    }
	
	/**
	 * Called before the screen is destroyed.
	 */
	public function destroy():Void
    {
        if (!_isInitialized) { return; }
        _isInitialized = false;
    }

    /**
     * Loads any required resources.
     */
    public function load():Void
    {
        if (_isLoaded) { return; }
        _isLoaded = true;
    }

    /**
     * Unloads any resources that may have been loaded.
     */
    public function unload():Void
    {
        if (!_isLoaded) { return; }
        _isLoaded = false;
    }

    /**
     * Allows the screen to run logic, such as updating the transition position.
     *
     * @param elapsedMillis
     *      The time that has passed since the last update.
     * @param otherScreenHasFocus
     *      Whether another screen has got input focus.
     * @param covered
     *      Whether the screen is covered by another screen.
     */
    public function update(elapsedMillis:Float, otherScreenHasFocus:Bool, covered:Bool):Void
    {
        _otherScreenHasFocus = otherScreenHasFocus;

        if (this.isExiting)
        {
            // If the screen is going away to die, it should transition off.
            _state = EScreenState.TransitionOff;

            if (!this.updateTransition(elapsedMillis, this.transitionOffDuration, 1))
            {
                this.screenManager.removeScreen(this);
            }
        }
        else if (covered)
        {
            if (this.updateTransition(elapsedMillis, this.transitionOffDuration, 1))
            {
                // Still busy transitioning.
                _state = EScreenState.TransitionOff;
            }
            else
            {
                // Transition finished!
                _state = EScreenState.Hidden;
            }
        }
        else
        {
            if (this.updateTransition(elapsedMillis, this.transitionOnDuration, -1))
            {
                // Still busy transitioning.
                _state = EScreenState.TransitionOn;
            }
            else
            {
                // Transition finished!
                _state = EScreenState.Active;
            }
        }
    }

    /**
     * Tells the screen to go away. Unlike IScreenManager.removeScreen(), which instantly kills the
     * screen, this method respects the transition timings and will give the screen a chance to
     * gradually transition off.
     */
    public function exit():Void
    {
        // If the screen has a zero transition time, remove it immediately.
        if (_transitionOffDuration == 0.0)
        {
            this.screenManager.removeScreen(this);
        }
        // Otherwise, just indicate that it should transition off.
        else
        {
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
     * @return True if the transition is still not finished and false otherwise.
     */
    private function updateTransition(elapsedMillis:Float, transitionDuration:Float, direction:Int):Bool
    {
        var delta:Float = transitionDuration == 0 ? 1 : (elapsedMillis / transitionDuration);

        _transitionPosition += delta * direction;

        var transitioningOn:Bool = direction < 0;
        var transitioningOff:Bool = direction > 0;
        var fullyOn:Bool = _transitionPosition <= 0;
        var fullyOff:Bool = _transitionPosition >= 1;

        // Are we done transitioning?
        if ((transitioningOn && fullyOn) || (transitioningOff && fullyOff))
        {
            // The transition is finished so we return false.
            _transitionPosition = MathUtils.clamp(_transitionPosition, 0, 1);
            return false;
        }

        // We're still transitioning so we return true.
        return true;
    }

    //}
    //--------------------------------------------------------------------------------------------//

    //--------------------------------------------------------------------------------------------//
    //{ Properties
    //--------------------------------------------------------------------------------------------//

    /**
     * The screen manager to which the screen belongs.
     */
    public var screenManager(get, never):IScreenManager;
    private inline function get_screenManager():IScreenManager { return _screenManager; }

    /**
     * Whether the screen has been initialized.
     */
    public var isInitialized(get, never):Bool;
    private inline function get_isInitialized():Bool { return _isInitialized; }

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
    private inline function set_transitionOnDuration(value:Float):Float
    {
        return _transitionOnDuration = value;
    }

    /**
     * Indicates how long the screen takes to transition off when it is deactivated (in
     * milliseconds).
     */
    public var transitionOffDuration(get, set):Float;
    private inline function get_transitionOffDuration():Float { return _transitionOffDuration; }
    private inline function set_transitionOffDuration(value:Float):Float
    {
        return _transitionOffDuration = value;
    }

    /**
     * The current position of the screen transition ranging from 0 (fully active, no transition) to
     * 1 (fully transitioned off).
     */
    public var transitionPosition(get, set):Float;
    private inline function get_transitionPosition():Float { return _transitionPosition; }
    private inline function set_transitionPosition(value:Float):Float
    {
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
    private inline function set_isExiting(value:Bool):Bool { return _isExiting = value; }

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
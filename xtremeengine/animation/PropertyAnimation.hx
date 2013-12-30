package xtremeengine.animation;

import xtremeengine.animation.easing.EaseInOutCubic;
import xtremeengine.errors.Error;
import xtremeengine.utils.IEqualityComparer.IEqualityComparer;
import xtremeengine.utils.IPropertyUpdater.IPropertyUpdater;

/**
 * Animation which animates a property of an object.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class PropertyAnimation<T> implements IAnimation {
    private var _name:String;
    private var _propertyUpdater:IPropertyUpdater<T>;
    private var _equalityComparer:IEqualityComparer<T>;
    private var _initialValue:T;
    private var _finalValue:T;
    private var _duration:Float;
    private var _removeOnCompletion:Bool;
    private var _easingFunction:IEasingFunction;
    private var _interpolator:IInterpolator<T>;
    private var _isPlaying:Bool;
    private var _position:Float;
    private var _easedPosition:Float;

    //--------------------------------------------------------------------------------------------//

    /**
     * Initializes a new property animation instance.
     *
     * @param name
     *      The name of the animation.
     * @param propertyUpdater
     *      The property updater used to set the value of the property.
     * @param equalityComparer
     *      The equality comparer used to compare the values of the property.
     * @param initialValue
     *      The initial value of the property.
     * @param finalValue
     *      The final value of the property.
     * @param duration
     *      The total duration of the animation (in milliseconds).
     * @param removeOnCompletion = false
     *      Whether the animation is to be removed from the animation manager after it ends.
     * @param easingFunction
     *      The easing function for the animation.
     * @param interpolator
     *      The interpolator for the animation.
     */
    public function new(
        name:String,
        propertyUpdater:IPropertyUpdater<T>,
        equalityComparer:IEqualityComparer<T>,
        initialValue:T,
        finalValue:T,
        duration:Float,
        removeOnCompletion = false,
        easingFunction:IEasingFunction = null,
        interpolator:IInterpolator<T> = null) {
        _name = name;

        _propertyUpdater = propertyUpdater;
        if (_propertyUpdater == null) { throw new Error("The property updater can't be null"); }

        _equalityComparer = equalityComparer;
        if (_equalityComparer == null) { throw new Error("The equality comparer can't be null"); }

        _initialValue = initialValue;
        _finalValue = finalValue;
        _duration = duration;
        _removeOnCompletion = removeOnCompletion;
        _easingFunction = easingFunction == null ? new EaseInOutCubic() : easingFunction;
        _interpolator = interpolator;
        _isPlaying = false;
        _position = 0.0;
        _easedPosition = 0.0;
    }

    //--------------------------------------------------------------------------------------------//
    //{ Public Methods
    //--------------------------------------------------------------------------------------------//

    /**
	 * Updates the animation state.
	 *
	 * @param elapsedMillis
	 * 		The time that has passed since the last animation step.
	 */
	public function animationStep(elapsedMillis:Float):Void {
        if (!this.isPlaying) { return; }

        this.position += elapsedMillis / this.duration;
        if (this.isComplete) {
            this.position = 1.0;
            this.pause();
        }
    }
	
	/**
	 * Plays the animation from the beginning, if it is not playing.
	 */
	public function play():Void {
        if (!_isPlaying) {
            _isPlaying = true;
            this.position = 0.0;
        }
    }
	
	/**
	 * Stops the animation and goes to the beginning.
	 */
	public function stop():Void {
        if (_isPlaying) {
            _isPlaying = false;
            this.position = 0.0;
        }
    }
	
	/**
	 * Pauses the animation.
	 */
	public function pause():Void {
        _isPlaying = false;
    }
	
	/**
	 * Resumes the animation, if it is paused.
	 */
	public function resume():Void {
        _isPlaying = true;
    }
	
	/**
	 * Stops the animation and starts playing it from the beginning.
	 */
	public function restart():Void {
        _isPlaying = true;
        this.position = 0.0;
    }

    //}
    //--------------------------------------------------------------------------------------------//
	
    //--------------------------------------------------------------------------------------------//
    //{ Private Methods
    //--------------------------------------------------------------------------------------------//

    /**
     * Updates the property on the target object according to the current position of the animation.
     */
    private function updateProperty():Void {
        _easedPosition = _easingFunction == null ? _position : _easingFunction.ease(_position);

        if (_interpolator == null) { return; }

        // Calculate the new value of the property and set it.
        var propertyValue:T = _interpolator.interpolate(_easedPosition, _initialValue, _finalValue);
        _propertyUpdater.updateProperty(propertyValue);
    }

    //}
    //--------------------------------------------------------------------------------------------//

    //--------------------------------------------------------------------------------------------//
    //{ Properties
    //--------------------------------------------------------------------------------------------//

    /**
	 * Gets the name of the animation.
	 */
	public var name(get, never):String;
    private inline function get_name():String { return _name; }

    /**
     * The object which is responsible for updating the property.
     */
    public var propertyUpdater(get, never):IPropertyUpdater<T>;
    private inline function get_propertyUpdater():IPropertyUpdater<T> { return _propertyUpdater; }

    /**
     * The object used to compare values of the property.
     */
    public var equalityComparer(get, never):IEqualityComparer<T>;
    private inline function get_equalityComparer():IEqualityComparer<T> { return _equalityComparer; }

    /**
     * The initial value of the property.
     */
    public var initialValue(get, set):T;
    private inline function get_initialValue():T { return _initialValue; }
    private inline function set_initialValue(value:T):T { return _initialValue = value; }

    /**
     * The final value of the property.
     */
    public var finalValue(get, set):T;
    private inline function get_finalValue():T { return _finalValue; }
    private inline function set_finalValue(value:T):T { return _finalValue = value; }

    /**
     * The object used to ease the animation.
     */
    public var easingFunction(get, set):IEasingFunction;
    private inline function get_easingFunction():IEasingFunction { return _easingFunction; }
    private inline function set_easingFunction(value:IEasingFunction):IEasingFunction {
        return _easingFunction = value;
    }

    /**
     * The interpolator used to interpolate the values of the property.
     */
    public var interpolator(get, set):IInterpolator<T>;
    private inline function get_interpolator():IInterpolator<T> { return _interpolator; }
    private inline function set_interpolator(value:IInterpolator<T>):IInterpolator<T> {
        return _interpolator = value;
    }

    /**
	 * The duration of the animation (in milliseconds).
	 */
	public var duration(get, set):Float;
    private inline function get_duration():Float { return _duration; }
    private inline function set_duration(value:Float):Float { return _duration = value; }
	
	/**
	 * The current position in the animation (0: beginning -> 1: end).
	 */
	public var position(get, set):Float;
    private inline function get_position():Float { return _position; }
    private inline function set_position(value:Float):Float { return _position = value; }

	/**
	 * Whether the animation is playing.
	 */
	public var isPlaying(get, never):Bool;
    private inline function get_isPlaying():Bool { return _isPlaying; }
	
	/**
	 * Whether the animation is paused.
	 */
	public var isPaused(get, never):Bool;
    private inline function get_isPaused():Bool { return !_isPlaying; }
	
	/**
	 * Whether the animation has finished played.
	 */
	public var isComplete(get, never):Bool;
    private inline function get_isComplete():Bool { return this.position >= 1.0; }
	
	/**
	 * Whether the animation is to be removed from the animation manager after it is completed.
	 */
	public var removeOnCompletion(get, set):Bool;
    private inline function get_removeOnCompletion():Bool { return _removeOnCompletion; }
    private inline function set_removeOnCompletion(value:Bool):Bool {
        return _removeOnCompletion = value;
    }

    //}
    //--------------------------------------------------------------------------------------------//
}
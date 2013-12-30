package xtremeengine.animation;

import xtremeengine.INamed;

/**
 * Interface which must be implemented by all the animations. An animation updates a numeric
 * property on an object using an easing/interpolation function.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IAnimation extends INamed {
	/**
	 * Updates the animation state.
	 *
	 * @param elapsedMillis
	 * 		The time that has passed since the last animation step.
	 */
	public function animationStep(elapsedMillis:Float):Void;
	
	/**
	 * Plays the animation from the beginning, if it is not playing.
	 */
	public function play():Void;
	
	/**
	 * Stops the animation and goes to the beginning.
	 */
	public function stop():Void;
	
	/**
	 * Pauses the animation.
	 */
	public function pause():Void;
	
	/**
	 * Resumes the animation, if it is paused.
	 */
	public function resume():Void;
	
	/**
	 * Stops the animation and starts playing it from the beginning.
	 */
	public function restart():Void;
	
	/**
	 * The duration of the animation (in milliseconds).
	 */
	public var duration(get, set):Float;
	
	/**
	 * The current position in the animation (0: beginning -> 1: end).
	 */
	public var position(get, set):Float;
	
	/**
	 * Whether the animation is playing.
	 */
	public var isPlaying(get, never):Bool;
	
	/**
	 * Whether the animation is paused.
	 */
	public var isPaused(get, never):Bool;
	
	/**
	 * Whether the animation has finished played.
	 */
	public var isComplete(get, never):Bool;
	
	/**
	 * Whether the animation is to be removed from the animation manager after it is completed.
	 */
	public var removeOnCompletion(get, set):Bool;
}
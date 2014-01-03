package xtremeengine.animation;
import xtremeengine.ICorePlugin;
import xtremeengine.IUpdateable;

/**
 * Interface must be implemented by all the animation managers. The animation manager is responsible
 * for managing all the animations. When an animation is added to the animation manager it is
 * automatically updated on each update step if it is not paused or stopped. The animation manager
 * also allows the user to stop, pause or resume all of the animations it manages.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IAnimationManager extends ICorePlugin extends IAnimationCollection extends IUpdateable {
	/**
	 * Plays all the animations.
	 */
	public function playAll():Void;
	
	/**
	 * Stops all the animations.
	 */
	public function stopAll():Void;
	
	/**
	 * Pauses all the animations.
	 */
	public function pauseAll():Void;
	
	/**
	 * Resumes all the animations.
	 */
	public function resumeAll():Void;
	
	/**
	 * Restarts all the animations.
	 */
	public function restartAll():Void;
}
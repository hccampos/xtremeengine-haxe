package xtremeengine.animation;

import promhx.Promise;
import xtremeengine.errors.Error;
import xtremeengine.ICore;
import xtremeengine.CorePlugin;

/**
 * Default implementation of the IAnimationManager interface.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class AnimationManager extends CorePlugin implements IAnimationManager {
    private var _animations:Array<IAnimation>;
    private var _isEnabled:Bool;
    private var _updateOrder:Int;

    //--------------------------------------------------------------------------------------------//

    /**
     * Initializes a new DefaultAnimationManager
     *
     * @param core
     *      The core object to which the animation manager belongs.
     * @param name
     *      The name of the animation manager.
     */
    public function new(core:ICore, name:String):Void {
        super(core, name);

        _animations = new Array<IAnimation>();
        _isEnabled = true;
        _updateOrder = 0;
    }

    //--------------------------------------------------------------------------------------------//
    //{ Public Methods
    //--------------------------------------------------------------------------------------------//

    /**
	 * Called before the plugin is removed from the core object or when the core object is about to
	 * be destroyed. The plugin should destroy any resources it may have created.
	 */
	public override function destroy():Void {
        for (animation in _animations) {
            animation.stop();
        }

        _animations = null;

        super.destroy();
    }

    /**
	 * Updates all the animations managed by the manager.
	 *
	 * @param elapsedTime
	 * 		The number of milliseconds elapsed since the last update.
	 */
	public function update(elapsedMillis:Float):Void {
        var toRemove:Array<IAnimation> = new Array<IAnimation>();

        for (animation in _animations) {
            animation.animationStep(elapsedMillis);

            if (animation.isComplete && animation.removeOnCompletion) {
                toRemove.push(animation);
            }
        }

        // Remove all the animations that are complete and marked for removal after completion.
        for (animation in toRemove) {
            this.removeAnimation(animation);
        }
    }

    /**
	 * Plays all the animations.
	 */
	public function playAll():Void {
        for (animation in _animations) {
            animation.play();
        }
    }
	
	/**
	 * Stops all the animations.
	 */
	public function stopAll():Void {
        for (animation in _animations) {
            animation.stop();
        }
    }
	
	/**
	 * Pauses all the animations.
	 */
	public function pauseAll():Void {
        for (animation in _animations) {
            animation.pause();
        }
    }
	
	/**
	 * Resumes all the animations.
	 */
	public function resumeAll():Void {
        for (animation in _animations) {
            animation.resume();
        }
    }
	
	/**
	 * Restarts all the animations.
	 */
	public function restartAll():Void {
        for (animation in _animations) {
            animation.restart();
        }
    }
	
	/**
	 * Adds an animation to the manager.
	 *
	 * @param animation
	 * 		The animation which is to be added.
	 */
	public function addAnimation(animation:IAnimation):Void {
        if (animation == null) { throw new Error("Trying to add a null animation."); }
        if (Lambda.has(_animations, animation)) {
            throw new Error("Trying to add an animation that has already been added to the manager.");
        }

        _animations.push(animation);
    }
	
	/**
	 * Removes the specified animation from the manager.
	 *
	 * @param animation
	 * 		The animation which is to be added to the manager.
	 *
	 * @return True if the animation was removed and false otherwise.
	 */
	public function removeAnimation(animation:IAnimation):Bool {
        if (animation == null) { return false; }
        return _animations.remove(animation);
    }

    /**
	 * Removes the animation which has the specified name from the collection.
	 *
	 * @param name
	 * 		The name of the animation which is to be added to the collection.
	 *
	 * @return True if the animation was removed and false otherwise.
	 */
	public function removeAnimationByName(name:String):Bool {
        return this.removeAnimation(this.getAnimationByName(name));
    }
	
	/**
	 * Removes all the animations from the manager.
	 */
	public function removeAllAnimations():Void {
        var toRemove:Array<IAnimation> = _animations.concat([]);
        for (animation in toRemove) {
            this.removeAnimation(animation);
        }
    }
	
    /**
     * Gets the animation which has the specified name.
     *
     * @param name
     *      The name of the animation which is to be retrieved.
     *
     * @return The animation that has the specified name or null if the animation can't be found.
     */
    public function getAnimationByName(name:String):IAnimation {
        if (name == null || name == "") { return null; }

        for (animation in _animations) {
            if (animation.name == name) { return animation; }
        }

        return null;
    }

	/**
	 * Gets whether the manager has the specified animation.
	 *
	 * @param animation
	 * 		The animation which is to be found.
	 *
	 * @return True if the manager has the specified animation and false otherwise.
	 */
	public function hasAnimation(animation:IAnimation):Bool {
        return Lambda.has(_animations, animation);
    }

    /**
	 * Gets whether the collection has an animation with the specified name.
	 *
	 * @param name
	 * 		The name of the animation which is to be found.
	 *
	 * @return True if the collection has the specified animation and false otherwise.
	 */
	public function hasAnimationNamed(name:String):Bool {
        return this.getAnimationByName(name) != null;
    }

    //}
    //--------------------------------------------------------------------------------------------//

    //--------------------------------------------------------------------------------------------//
    //{ Properties
    //--------------------------------------------------------------------------------------------//

    /**
	 * The animations which are being managed by the animation manager.
	 */
	public var animations(get, never):Array<IAnimation>;
    private inline function get_animations():Array<IAnimation> { return _animations; }

    /**
	 * Whether the object is enabled.
	 */
	public var isEnabled(get, set):Bool;
    private inline function get_isEnabled():Bool { return _isEnabled; }
    private inline function set_isEnabled(value:Bool):Bool { return _isEnabled = value; }
	
	/**
	 * Value used to sort objects before updating.
	 */
	public var updateOrder(get, set):Int;
    private inline function get_updateOrder():Int { return _updateOrder; }
    private inline function set_updateOrder(value:Int):Int { return _updateOrder = value; }

    //}
    //--------------------------------------------------------------------------------------------//
}
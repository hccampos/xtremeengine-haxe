package xtremeengine.animation;

/**
 * Interface which defines a collection of animations.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IAnimationCollection
{
    /**
	 * Adds an animation to the collection.
	 *
	 * @param animation
	 * 		The animation which is to be added.
	 */
	public function addAnimation(animation:IAnimation):Void;
	
	/**
	 * Removes the specified animation from the collection.
	 *
	 * @param animation
	 * 		The animation which is to be added to the collection.
	 *
	 * @return True if the animation was removed and false otherwise.
	 */
	public function removeAnimation(animation:IAnimation):Bool;
	
    /**
	 * Removes the animation which has the specified name from the collection.
	 *
	 * @param name
	 * 		The name of the animation which is to be added to the collection.
	 *
	 * @return True if the animation was removed and false otherwise.
	 */
	public function removeAnimationByName(name:String):Bool;

	/**
	 * Removes all the animations from the collection.
	 */
	public function removeAllAnimations():Void;
	
    /**
     * Gets the animation which has the specified name.
     *
     * @param name
     *      The name of the animation which is to be retrieved.
     *
     * @return The animation that has the specified name or null if the animation can't be found.
     */
    public function getAnimationByName(name:String):IAnimation;

	/**
	 * Gets whether the collection has the specified animation.
	 *
	 * @param animation
	 * 		The animation which is to be found.
	 *
	 * @return True if the collection has the specified animation and false otherwise.
	 */
	public function hasAnimation(animation:IAnimation):Bool;
	
    /**
	 * Gets whether the collection has an animation with the specified name.
	 *
	 * @param name
	 * 		The name of the animation which is to be found.
	 *
	 * @return True if the collection has the specified animation and false otherwise.
	 */
	public function hasAnimationNamed(name:String):Bool;

	/**
	 * The animations which are in the collection.
	 */
	public var animations(get, never):Array<IAnimation>;
}
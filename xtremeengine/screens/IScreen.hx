package xtremeengine.screens;

import xtremeengine.ICoreObject;
import xtremeengine.IInitializable;
import xtremeengine.ILoadable;
import xtremeengine.IUpdateable;

/**
 * Interface which defines a screen. A screen can be a menu, the main gameplay screen, a settings
 * screen, etc.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IScreen extends IInitializable extends ILoadable
{
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
    public function update(elapsedMillis:Float, otherScreenHasFocus:Bool, covered:Bool):Void;

    /**
     * Tells the screen to go away. Unlike IScreenManager.removeScreen(), which instantly kills the
     * screen, this method respects the transition timings and will give the screen a chance to
     * gradually transition off.
     */
    public function exit():Void;

    /**
     * The screen manager to which the screen belongs.
     */
    public var screenManager(get, never):IScreenManager;

    /**
     * Indicates how long the screen takes to transition on when it is activated (in milliseconds).
     */
    public var transitionOnDuration(get, set):Float;

    /**
     * Indicates how long the screen takes to transition off when it is deactivated (in
     * milliseconds).
     */
    public var transitionOffDuration(get, set):Float;

    /**
     * The current position of the screen transition ranging from 0 (fully active, no transition) to
     * 1 (fully transitioned off).
     */
    public var transitionPosition(get, set):Float;

    /**
     * The current alpha of the screen transition, ranging from 1 (fully active, no transition) to 0
     * (transitioned fully off to nothing).
     */
    public var transitionAlpha(get, never):Float;

    /**
     * The current transition state.
     */
    public var state(get, set):EScreenState;

    /**
     * Normally when one screen is brought up over the top of another, the first screen will
     * transition off to make room for the new one. This property indicates whether the screen is
     * only a popup, in which case screens underneath it do not need to bother transitioning off.
     */
    public var isPopup(get, set):Bool;

    /**
     * There are two possible reasons why a screen might be transitioning off. It could be
     * temporarily going away to make room for another screen that is on top of it, or it could be
     * going away for good. This property indicates whether the screen is exiting for good: if set,
     * the screen will automatically remove itself as soon as the transition finishes.
     */
    public var isExiting(get, never):Bool;

    /**
     * Whether this screen is active and can respond to user input.
     */
    public var isActive(get, never):Bool;
}
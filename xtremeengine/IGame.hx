package xtremeengine;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import msignal.Signal.Signal0;
import msignal.Signal.Signal2;
import xtremeengine.screens.IScreenManager;

/**
 * Interface which defines an XtremeEngine game.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IGame {
    /**
     * The context where the game is to be displayed.
     */
    public var context(get, never):Context;

    /**
     * The screen manager of the game.
     */
    public var screenManager(get, never):IScreenManager;

    /**
     * The width of the game screen/window.
     */
    public var width(get, never):Float;

    /**
     * The height of the game screen/window.
     */
    public var height(get, never):Float;

    /**
     * The target frame rate.
     */
    public var targetFps(get, set):Int;

    /**
     * The scale mode of the stage.
     */
    public var scaleMode(get, set):StageScaleMode;

    /**
     * The align mode of the stage.
     */
    public var align(get, set):StageAlign;

    /**
     * Whether the game has a valid context that is added to the stage.
     */
    public var hasValidContext(get, never):Bool;

    /**
     * Signal which is dispatched when the game is activated.
     */
    public var onActivate(get, never):Signal0;

    /**
     * Signal which is dispatched when the game is deactivated.
     */
    public var onDeactivate(get, never):Signal0;

    /**
     * Signal which is dispatched when the game is resized.
     */
    public var onResize(get, never):Signal2<Float, Float>;
}
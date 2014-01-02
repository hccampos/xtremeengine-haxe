package xtremeengine;

import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import msignal.Signal.Signal0;
import msignal.Signal.Signal2;
import xtremeengine.errors.Error;
import xtremeengine.screens.IScreenManager;
import xtremeengine.screens.ScreenManager;

/**
 * Game base class.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class Game implements IGame
{
    private var _context:Context;
    private var _screenManager:IScreenManager;
    private var _isInitialized:Bool;
    private var _targetFps:Int;
    private var _scaleMode:StageScaleMode;
    private var _align:StageAlign;
    private var _lastTime:Int;

    private var _onActivateSignal:Signal0;
    private var _onDeactivateSignal:Signal0;
    private var _onResizeSignal:Signal2<Float, Float>;

    //--------------------------------------------------------------------------------------------//

    /**
     * Creates the new game.
     */
    public function new(context:Context)
    {
        _context = context;
        _screenManager = null;
        _isInitialized = false;
        _targetFps = 60;
        _scaleMode = StageScaleMode.NO_SCALE;
        _align = StageAlign.TOP_LEFT;

        _onActivateSignal = new Signal0();
        _onDeactivateSignal = new Signal0();
        _onResizeSignal = new Signal2<Float, Float>();

        _context.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    //--------------------------------------------------------------------------------------------//
    //{ Private Methods
    //--------------------------------------------------------------------------------------------//

    /**
	 * Initializes the game.
	 */
	private function initialize():Void {
        if (_isInitialized) { return; }
		
        this.setupStage();

        _screenManager = new ScreenManager(this);
        this.setupInitialScreens();
        _screenManager.initialize();

        _isInitialized = true;
    }

    /**
     * Creates the initial screens and adds them to the screen manager.
     */
    private function setupInitialScreens():Void {}

    /**
     * Configures and prepares the stage to which the context of the game has been added.
     */
    private function setupStage():Void {
        if (!this.hasValidContext) { throw new Error("No valid context or stage."); }

        var stage:Stage = this.context.stage;
        stage.align = this.align;
		stage.scaleMode = this.scaleMode;
		stage.frameRate = this.targetFps;

        stage.addEventListener(Event.ENTER_FRAME, update);
		stage.addEventListener(Event.ACTIVATE, onActivateHandler);
		stage.addEventListener(Event.DEACTIVATE, onDeactivateHandler);
        stage.addEventListener(Event.RESIZE, onResizeHandler);
    }

    /**
     * Updates the game.
     */
    private function update(event:Event):Void {
        if (_lastTime == 0) {
			_lastTime = Lib.getTimer();
			return;
		}

		var currentTime:Int = Lib.getTimer();
		var elapsedMillis:Int = currentTime - _lastTime;
		_lastTime = currentTime;
		
		_screenManager.update(elapsedMillis);
    }

    /**
     * Activates the game. This should be called when the window or app gains focus.
     */
    private function onActivateHandler(event:Event):Void {
        #if (mobile)
		_context.stage.frameRate = 1;
		#end

        this.onActivate.dispatch();
    }

    /**
     * Deactivates the game. This should be called when the window or app loses focus.
     */
    private function onDeactivateHandler(event:Event):Void {
        #if (mobile)
		_context.stage.frameRate = TARGET_FPS;
		#end

        this.onDeactivate.dispatch();
    }

    /**
	 * Called when the stage is resized.
	 *
	 * @param	event
	 * 		Object with the event details.
	 */
    private function onResizeHandler(event:Event):Void {
        if (!this.hasValidContext) { return; }

        var newWidth:Float = _context.stage.stageWidth;
        var newHeight:Float = _context.stage.stageHeight;

        this.onResize.dispatch(newWidth, newHeight);
    }

    /**
	 * Called when the context of the game has been added to the stage.
	 *
	 * @param	event
	 * 		Object with the event details.
	 */
	private function onAddedToStage(e) {
		_context.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

		#if ios
			haxe.Timer.delay(this.initialize, 100); // iOS 6
		#else
			this.initialize();
		#end
	}

    //}
    //--------------------------------------------------------------------------------------------//

    //--------------------------------------------------------------------------------------------//
    //{ Properties
    //--------------------------------------------------------------------------------------------//

    /**
     * The context where the game is to be displayed.
     */
    public var context(get, never):Context;
    private inline function get_context():Context { return _context; }

    /**
     * The screen manager of the game.
     */
    public var screenManager(get, never):IScreenManager;
    private inline function get_screenManager():IScreenManager { return _screenManager; }

    /**
     * The width of the game screen/window.
     */
    public var width(get, never):Float;
    private inline function get_width():Float { return this.context.stage.stageWidth; }

    /**
     * The height of the game screen/window.
     */
    public var height(get, never):Float;
    private inline function get_height():Float { return this.context.stage.stageHeight; }

    /**
     * The target frame rate.
     */
    public var targetFps(get, set):Int;
    private inline function get_targetFps():Int { return _targetFps; }
    private inline function set_targetFps(value:Int):Int {
        _targetFps = value;
        if (this.hasValidContext) { _context.stage.frameRate = _targetFps; }
        return _targetFps;
    }

    /**
     * The scale mode of the stage.
     */
    public var scaleMode(get, set):StageScaleMode;
    private inline function get_scaleMode():StageScaleMode { return _scaleMode; }
    private inline function set_scaleMode(value:StageScaleMode):StageScaleMode {
        _scaleMode = value;
        if (this.hasValidContext) { _context.stage.scaleMode = _scaleMode; }
        return _scaleMode;
    }

    /**
     * The align mode of the stage.
     */
    public var align(get, set):StageAlign;
    private inline function get_align():StageAlign { return _align; }
    private inline function set_align(value:StageAlign) {
        _align = value;
        if (this.hasValidContext) { _context.stage.align = _align; }
        return _align;
    }

    /**
     * Whether the game has a valid context that is added to the stage.
     */
    public var hasValidContext(get, never):Bool;
    private inline function get_hasValidContext():Bool {
        return _context != null && _context.stage != null;
    }

    /**
     * Signal which is dispatched when the game is activated.
     */
    public var onActivate(get, never):Signal0;
    private inline function get_onActivate():Signal0 { return _onActivateSignal; }

    /**
     * Signal which is dispatched when the game is deactivated.
     */
    public var onDeactivate(get, never):Signal0;
    private inline function get_onDeactivate():Signal0 { return _onDeactivateSignal; }

    /**
     * Signal which is dispatched when the game is resized.
     */
    public var onResize(get, never):Signal2<Float, Float>;
    private inline function get_onResize():Signal2 <Float, Float> { return _onResizeSignal; }

    //}
    //--------------------------------------------------------------------------------------------//
}
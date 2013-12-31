package xtremeengine;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import xtremeengine.errors.Error;
import xtremeengine.screens.IScreenManager;
import xtremeengine.screens.ScreenManager;

/**
 * Game base class.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class Game
{
    private var _context:Context;
    private var _screenManager:IScreenManager;
    private var _isInitialized:Bool;
    private var _targetFps:Int;
    private var _scaleMode:StageScaleMode;
    private var _align:StageAlign;
    private var _lastTime:Int;

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

        _context.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    //--------------------------------------------------------------------------------------------//
    //{ Methods
    //--------------------------------------------------------------------------------------------//

    /**
	 * Initializes the game.
	 */
	private function initialize():Void {
        if (_isInitialized) { return; }
		
        this.setupStage();

        _screenManager = new ScreenManager(_context);
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

        _context.stage.align = this.align;
		_context.stage.scaleMode = this.scaleMode;
		_context.stage.frameRate = this.targetFps;

        _context.stage.addEventListener(Event.ENTER_FRAME, update);
		_context.stage.addEventListener(Event.ACTIVATE, onActivate);
		_context.stage.addEventListener(Event.DEACTIVATE, onDeactivate);
        _context.stage.addEventListener(Event.RESIZE, onResize);
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
    private function onActivate(event:Event):Void {
        #if (mobile)
		_context.stage.frameRate = 1;
		#end
    }

    /**
     * Deactivates the game. This should be called when the window or app loses focus.
     */
    private function onDeactivate(event:Event):Void {
        #if (mobile)
		_context.stage.frameRate = TARGET_FPS;
		#end
    }

    /**
	 * Called when the stage is resized.
	 *
	 * @param	event
	 * 		Object with the event details.
	 */
    private function onResize(event:Event):Void {
        if (!this.hasValidContext) { return; }

        var newWidth:Float = _context.stage.stageWidth;
        var newHeight:Float = _context.stage.stageHeight;
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
     * The screen manager of the game.
     */
    public var screenManager(get, never):IScreenManager;
    private inline function get_screenManager():IScreenManager { return _screenManager; }

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

    //}
    //--------------------------------------------------------------------------------------------//
}
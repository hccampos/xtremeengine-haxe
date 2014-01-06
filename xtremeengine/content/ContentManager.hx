package xtremeengine.content;

import flash.display.BitmapData;
import flash.media.Sound;
import flash.system.Capabilities;
import flash.text.Font;
import openfl.Assets;
import promhx.Promise;
import xtremeengine.ICore;
import xtremeengine.GamePlugin;
import xtremeengine.IGame;

/**
 * Default implementation of the IContentManager interface.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class ContentManager extends GamePlugin implements IContentManager {
    private var _assetsPath:String = null;
    private var _normalDpiAssetsPath:String = null;
    private var _mediumDpiAssetsPath:String = null;
    private var _highDpiAssetsPath:String = null;

    /**
     * Constructor.
     *
     * @param game
     *      The game to which the manager belongs.
     * @param name
     *      The name of the manager.
     */
    public function new(game:IGame, name:String):Void {
        super(game, name);

        _assetsPath = "assets/";
        _normalDpiAssetsPath = "160dpi/";
        _mediumDpiAssetsPath = "240dpi/";
    }

    /**
	 * Initializes the plugin.
	 */
	public override function initialize():Void {
        super.initialize();
    }
	
	/**
	 * Called before the plugin is removed from the core object or when the core object is about to
	 * be destroyed. The plugin should destroy any resources it may have created.
	 */
	public override function destroy():Void {
        super.destroy();
    }

    /**
     * Loads a texture.
     *
     * @param path
     *      The path to the texture which is to be loaded.
     *
     * @return A promise which is resolved with the BitmapData object which contains the data of the
     * texture that was loaded.
     */
    public function loadTexture(path:String, dpi:Float = 0):Promise<BitmapData> {
        var p:Promise<BitmapData> = new Promise<BitmapData>();

        if (dpi <= 0) { dpi = Capabilities.screenDPI;  }

        var assetsPath:String = _assetsPath;

        if (dpi < 220) {
            assetsPath += _normalDpiAssetsPath;
        } else if (dpi >= 220 && dpi < 300) {
            assetsPath += _mediumDpiAssetsPath;
        } else {
            assetsPath += _highDpiAssetsPath;
        }

        Assets.loadBitmapData(assetsPath + path, function (bmpData:BitmapData):Void {
            p.resolve(bmpData);
        });

        return p;
    }

    /**
     * Loads a font file.
     *
     * @param path
     *      The path to the font which is to be loaded.
     *
     * @return A promise which is resolved with the font that was loaded.
     */
    public function loadFont(path:String):Promise<Font> {
        var p:Promise<Font> = new Promise<Font>();

        Assets.loadFont(_assetsPath + path, function (font:Font):Void {
            p.resolve(font);
        });

        return p;
    }

    /**
     * Loads a sound file.
     *
     * @param path
     *      The path to the sound which is to be loaded.
     *
     * @return A promise which is resolved with the sound that was loaded.
     */
    public function loadSound(path:String):Promise<Sound> {
        var p:Promise<Sound> = new Promise<Sound>();

        Assets.loadSound(_assetsPath + path, function (sound:Sound):Void {
            p.resolve(sound);
        });

        return p;
    }

    /**
     * Loads a text file.
     *
     * @param path
     *      The path to the text file which is to be loaded.
     *
     * @return A promise which is resolved with the contents of the file that was loaded.
     */
    public function loadText(path:String):Promise<String> {
        var p:Promise<String> = new Promise<String>();

        Assets.loadText(_assetsPath + path, function (text:String):Void {
            p.resolve(text);
        });

        return p;
    }

    /**
     * The path to the folder where the assets are stored.
     */
    public var assetsPath(get, set):String;
    private inline function get_assetsPath():String { return _assetsPath; }
    private inline function set_assetsPath(value:String):String { return _assetsPath = value; }

    /**
     * The path to the folder which contains the normal DPI assets.
     */
    public var normalDpiAssetsPath(get, set):String;
    private inline function get_normalDpiAssetsPath():String { return _normalDpiAssetsPath; }
    private inline function set_normalDpiAssetsPath(value:String):String {
        return _normalDpiAssetsPath = value;
    }

    /**
     * The path to the folder which contains the medium DPI assets.
     */
    public var mediumDpiAssetsPath(get, set):String;
    private inline function get_mediumDpiAssetsPath():String { return _mediumDpiAssetsPath; }
    private inline function set_mediumDpiAssetsPath(value:String):String {
        return _mediumDpiAssetsPath = value;
    }

    /**
     * The path to the folder which contains the high DPI assets.
     */
    public var highDpiAssetsPath(get, set):String;
    private inline function get_highDpiAssetsPath():String { return _highDpiAssetsPath; }
    private inline function set_highDpiAssetsPath(value:String):String {
        return _highDpiAssetsPath = value;
    }
}
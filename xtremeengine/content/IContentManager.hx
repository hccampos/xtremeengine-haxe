package xtremeengine.content;

import flash.display.BitmapData;
import flash.media.Sound;
import flash.text.Font;
import promhx.Promise;
import xtremeengine.IGamePlugin;

/**
 * Interface which must be implemented by all the content managers.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IContentManager extends IGamePlugin {
    /**
     * Loads a texture.
     *
     * @param path
     *      The path to the texture which is to be loaded.
     * @param dpi
     *      The dpi of the desired texture. This will be used to select the correct folder to load
     *      the texture.
     *
     * @return A promise which is resolved with the BitmapData object which contains the data of the
     * texture that was loaded.
     */
    public function loadTexture(path:String, dpi:Float = 0):Promise<BitmapData>;

    /**
     * Loads a font file.
     *
     * @param path
     *      The path to the font which is to be loaded.
     *
     * @return A promise which is resolved with the font that was loaded.
     */
    public function loadFont(path:String):Promise<Font>;

    /**
     * Loads a sound file.
     *
     * @param path
     *      The path to the sound which is to be loaded.
     *
     * @return A promise which is resolved with the sound that was loaded.
     */
    public function loadSound(path:String):Promise<Sound>;

    /**
     * Loads a text file.
     *
     * @param path
     *      The path to the text file which is to be loaded.
     *
     * @return A promise which is resolved with the contents of the file that was loaded.
     */
    public function loadText(path:String):Promise<String>;

    /**
     * The path to the folder where the assets are stored.
     */
    public var assetsPath(get, set):String;

    /**
     * The path to the folder which contains the normal DPI assets.
     */
    public var normalDpiAssetsPath(get, set):String;

    /**
     * The path to the folder which contains the medium DPI assets.
     */
    public var mediumDpiAssetsPath(get, set):String;

    /**
     * The path to the folder which contains the high DPI assets.
     */
    public var highDpiAssetsPath(get, set):String;
}
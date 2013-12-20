package xtremeengine.screens;

/**
 * Interface which defines a collection of screens.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IScreenCollection
{
    /**
     * Adds the specified screen to the collection.
     *
     * @param screen
     *      The screen which is to be added.
     */
    public function addScreen(screen:IScreen):Void;

    /**
     * Removes the specified screen from the collection.
     *
     * @param screen
     *      The screen which is to be removed.
     *
     * @return True if the screen was removed and false otherwise.
     */
    public function removeScreen(screen:IScreen):Bool;

    /**
     * Removes all the screens from the collection.
     */
    public function removeAllScreens():Void;

    /**
     * Gets whether the collection has the specified screen.
     *
     * @param screen
     *      The screen which is to be found.
     *
     * @return True if the collection has the specified screen and false otherwise.
     */
    public function hasScreen(screen:IScreen):Bool;

    /**
     * The screens that make up the collection.
     */
    public var screens(get, never):Array<IScreen>;
}
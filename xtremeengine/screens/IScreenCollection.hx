package xtremeengine.screens;

import promhx.Promise;

/**
 * Interface which defines a collection of screens.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IScreenCollection {
    /**
     * Adds the specified screen to the collection.
     *
     * @param screen
     *      The screen which is to be added.
     *
     * @return A promise which is resolved when the screen has been added and loaded.
     */
    public function addScreen(screen:IScreen):Promise<Bool>;

    /**
     * Removes the specified screen from the collection.
     *
     * @param screen
     *      The screen which is to be removed.
     *
     * @return A promise which is resolved when the screen has been removed.
     */
    public function removeScreen(screen:IScreen):Promise<Bool>;

    /**
     * Removes all the screens from the collection.
     *
     * @return A promise which is resolved when all the promises have been removed.
     */
    public function removeAllScreens():Promise<Bool>;

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
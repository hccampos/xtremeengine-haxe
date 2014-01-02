package xtremeengine;

/**
 * Interface which defines elements that can be resized.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IResizable
{
    /**
     * Resizes the element.
     *
     * @param newWidth
     *      The new width of the container.
     * @param newHeight
     *      The new height of the container.
     */
    public function resize(newWidth:Float, newHeight:Float):Void;
}
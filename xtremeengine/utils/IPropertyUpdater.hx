package xtremeengine.utils;

/**
 * Interface which defines a property updater. A property updater allows a property animation to set
 * the value of a property.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IPropertyUpdater<T>
{
    /**
     * Sets the property to the specified value.
     *
     * @param value
     *      The value which is to be set on the property.
     *
     * @return The new value of the property.
     */
    public function updateProperty(value:T):Void;
}
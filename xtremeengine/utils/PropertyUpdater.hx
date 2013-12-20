package xtremeengine.utils;

/**
 * Property updater which updates a simple property in an object.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class PropertyUpdater<T> implements IPropertyUpdater<T>
{
    // Function which updates the object.
    private var _updatePropertyFunction:T->Void;

    public function new(propertyUpdateFunction)
    {
        _updatePropertyFunction = propertyUpdateFunction;
    }

    /**
     * Sets the property to the specified value.
     *
     * @param value
     *      The value which is to be set on the property.
     *
     * @return The new value of the property.
     */
    public function updateProperty(value:T):Void
    {
        if (_updatePropertyFunction == null) { return; }
        _updatePropertyFunction(value);
    }
}
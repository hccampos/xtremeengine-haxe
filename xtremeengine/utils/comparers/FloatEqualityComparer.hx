package xtremeengine.utils.comparers;

import xtremeengine.utils.IEqualityComparer;

/**
 * Euqality comparer which can compare floats.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class FloatEqualityComparer implements IEqualityComparer<Float>
{
    public function new() {}

    /**
     * Gets whether the specified values are the same.
     *
     * @param a
     *      The value to which b is to be compared.
     * @param b
     *      The value to which a is to be compared.
     *
     * @return True if a and b are equal and false otherwise.
     */
    public function equals(a:Float, b:Float):Bool
    {
        return a == b;
    }

}
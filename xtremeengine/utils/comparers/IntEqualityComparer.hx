package xtremeengine.utils.comparers;

import xtremeengine.utils.IEqualityComparer;

/**
 * Euqality comparer which can compare integers.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class IntEqualityComparer implements IEqualityComparer<Int>
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
    public function equals(a:Int, b:Int):Bool
    {
        return a == b;
    }

}
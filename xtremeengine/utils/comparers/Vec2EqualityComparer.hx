package xtremeengine.utils.comparers;

import xtremeengine.utils.IEqualityComparer;
import xtremeengine.utils.Vec2;

/**
 * Euqality comparer which can compare 2D vectors.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class Vec2EqualityComparer implements IEqualityComparer<Vec2>
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
    public function equals(a:Vec2, b:Vec2):Bool
    {
        return a.equals(b);
    }
}
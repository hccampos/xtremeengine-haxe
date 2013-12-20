package xtremeengine.utils;

/**
 * Interface of an equality comparer. An equality comparer can compare two values.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IEqualityComparer<T>
{
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
    public function equals(a:T, b:T):Bool;
}
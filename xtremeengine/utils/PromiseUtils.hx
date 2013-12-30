package xtremeengine.utils;

import promhx.Promise;

/**
 * Contains several helpers for working with promises.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class PromiseUtils
{
	private function new() { }
	
    public static function resolved<T>(value:T):Promise<T>
    {
        var p:Promise<T> = new Promise<T>();
        p.resolve(value);
        return p;
    }

    public static function rejected<T>(error:Dynamic):Promise<T>
    {
        var p:Promise<T> = new Promise<T>();
        p.reject(error);
        return p;
    }

    public static function sequence<T>(promises : Iterable<Promise<T>>):Promise<Array<T>> {
        if (Lambda.empty(promises)) { return PromiseUtils.resolved([]); }

        var results:Array<T> = new Array<T>();
        var tmpPromise:Promise<T> = null;

        for (p in promises) {
            if (tmpPromise == null) {
                tmpPromise = p;
            } else {
                tmpPromise = tmpPromise.pipe(function (res:T):Promise<T> {
                    // Save the result and pipe to the next promise.
                    results.push(res);
                    return p;
                });
            }
        }

        return tmpPromise.then(function (res):Array<T> {
            results.push(res);
            return results;
        });
    }
}
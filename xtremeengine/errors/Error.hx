package xtremeengine.errors;

/**
 * Default error for XtremeEngine.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class Error extends flash.errors.Error {
    public function new(message:String) {
        super(message);
    }
}
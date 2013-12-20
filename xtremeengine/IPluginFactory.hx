package xtremeengine;

/**
 * ...
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IPluginFactory
{
    public function createContentManager(core:ICore, name:String);
}
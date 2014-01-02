package xtremeengine.entitycomponent.components;

import xtremeengine.entitycomponent.EntityComponent;

/**
 * Default implementation of the IResizeComponent interface.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
class ResizeComponent extends EntityComponent implements IResizeComponent
{
    /**
     *  Constructor.
     *
     * @param core
     *      The core to which the object belongs.
     * @param name
     *      The name of the component.
     */
    public function new(core:ICore, name:String):Void {
        super(core, name);
    }

    /**
	 * Called when another component is added or removed from the entity. This method should be used
	 * by the component to aquire or release references to other components in the entity.
	 */
	public override function onReset():Void {
        super.onReset();

        this.core.game.onResize.add(this.resize);
    }
	
	/**
	 * Called when the component is removed from an entity.
	 */
	public override function onRemove():Void {
        super.onRemove();

        this.core.game.onResize.remove(this.resize);
    }

     /**
     * Method which is called when the game screen/window is resized.
     */
    public function resize(newWidth:Float, newHeight:Float):Void {}
}
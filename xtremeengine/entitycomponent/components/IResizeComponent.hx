package xtremeengine.entitycomponent.components;

import xtremeengine.entitycomponent.IEntityComponent;

/**
 * Interface which defines a component which can perform logic when the game screen/window is
 * resized.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IResizeComponent extends IEntityComponent {
    /**
     * Method which is called when the game screen/window is resized.
     */
    public function resize(newWidth:Float, newHeight:Float):Void;
}
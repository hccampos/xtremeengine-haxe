package xtremeengine.entitycomponent;

import xtremeengine.IPlugin;
import xtremeengine.IUpdateable;

/**
 * Interface which must be implemented by all the entity managers.
 * An entity manager is responsible for managing all the entities in the game and making sure
 * that they properly integrate with each other.
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IEntityManager extends IPlugin extends IEntityCollection extends IUpdateable {}
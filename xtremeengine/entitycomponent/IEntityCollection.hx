package xtremeengine.entitycomponent;

/**
 *
 * @author Hugo Campos <hcfields@gmail.com> (www.hccampos.net)
 */
interface IEntityCollection
{
    /**
	 * Adds the specified entity to the collection.
	 *
	 * @param entity
	 * 		The entity which is to be added.
	 */
	public function addEntity(entity:IEntity):Void;
	
	/**
	 * Removes the specified entity from the collection.
	 *
	 * @param entity
	 * 		The entity which is to be removed.
	 *
	 * @return True if the entity was removed and false otherwise.
	 */
	public function removeEntity(entity:IEntity):Bool;
	
	/**
	 * Removes the entity which is identified by the specified name from the collection.
	 *
	 * @param name
	 * 		The name of the entity which is to be removed.
	 *
	 * @return True if the entity was removed and false otherwise.
	 */
	public function removeEntityByName(name:String):Bool;
	
	/**
	 * Removes all the entities from the collection.
	 */
	public function removeAllEntities():Void;

    /**
	 * Gets the entity which is identified by the specified name.
	 *
	 * @param name
	 * 		The name of the entity which is to be retrieved.
	 *
	 * @return The entity which is identified by the specified name.
	 */
	public function getEntityByName(name:String):IEntity;
	
    /**
	 * Gets whether the collection has the specified entity.
	 *
	 * @param entity
	 * 		The entity which is to be found.
	 *
	 * @return True if the collection has the specified entity and false otherwise.
	 */
	public function hasEntity(entity:IEntity):Bool;

    /**
	 * Gets whether the collection has the specified entity.
	 *
	 * @param name
	 * 		The name of the entity which is to be found.
	 *
	 * @return True if the collection has the specified entity and false otherwise.
	 */
	public function hasEntityNamed(name:String):Bool;

	/**
	 * The entities that are part of the collection.
	 */
	public var entities(get, never):Array<IEntity>;
}
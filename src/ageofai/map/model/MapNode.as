/**
 * Created by newkrok on 08/04/16.
 */
package ageofai.map.model
{
    import ageofai.map.constant.CMapNodeType;
	public class MapNode
	{
        private var _type:int;
		
        public function MapNode( type:int )
		{
            this._type = type;
		}
        
        public function get type():int 
        {
            return _type;
        }
        
        public function get walkable():Boolean
        {
            return this._type < CMapNodeType.WATER;
        }
        
        public function set objectType(value:int):void
        {
            this._type = this._type | value;
        }
        
        public function get objectType():int
        {
            return this._type & 0xFF00;
        }
        
        public function get baseNodeWalkable():Boolean
        {
            return (this._type & 0xFF) < CMapNodeType.WATER;
        }
	}
}
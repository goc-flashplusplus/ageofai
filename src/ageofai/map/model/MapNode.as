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
	}
}
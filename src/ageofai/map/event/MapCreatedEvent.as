package ageofai.map.event 
{
    import ageofai.map.vo.MapDataVO;
    import flash.events.Event;
	/**
     * ...
     * @author 
     */
    public class MapCreatedEvent extends Event
    {
        public static const MAP_CREATED:String = "MapEvent.mapCreated";
        
        private var _mapData:MapDataVO;
        
        public function MapCreatedEvent( type:String, mapData:MapDataVO, bubbles:Boolean = false, cancelable:Boolean = false )
        {
            super( type, bubbles, cancelable );
            this._mapData = mapData;
        }
        
        public function get mapData():MapDataVO
        {
            return this._mapData;
        }

        public override function clone():Event
        {
            var event:MapCreatedEvent = new MapCreatedEvent( type, this._mapData );

            return event;
        }
    }

}
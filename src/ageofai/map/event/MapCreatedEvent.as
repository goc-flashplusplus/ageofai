package ageofai.map.event 
{
    import ageofai.map.model.MapNode;
    import flash.events.Event;
	/**
     * ...
     * @author 
     */
    public class MapCreatedEvent extends Event
    {
        public static const MAP_CREATED:String = "MapEvent.mapCreated";
        
        private var _map:Vector.<Vector.<MapNode>>;

        public function MapCreatedEvent( type:String, map:Vector.<Vector.<MapNode>>, bubbles:Boolean = false, cancelable:Boolean = false )
        {
            super( type, bubbles, cancelable );
            this._map = map;
        }
        
        public function get map():Vector.<Vector.<MapNode>>
        {
            return this._map;
        }

        public override function clone():Event
        {
            var event:MapCreatedEvent = new MapCreatedEvent( type, this._map );

            return event;
        }
    }

}
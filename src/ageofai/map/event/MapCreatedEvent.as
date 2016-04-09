package ageofai.map.event 
{
    import ageofai.map.geom.IntPoint;
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
        private var _homes:Vector.<IntPoint>;

        public function MapCreatedEvent( type:String, map:Vector.<Vector.<MapNode>>, homes:Vector.<IntPoint>, bubbles:Boolean = false, cancelable:Boolean = false )
        {
            super( type, bubbles, cancelable );
            this._map = map;
            this._homes = homes;
        }
        
        public function get map():Vector.<Vector.<MapNode>>
        {
            return this._map;
        }

        public function get homes():Vector.<IntPoint>
        {
            return this._homes;
        }

        public override function clone():Event
        {
            var event:MapCreatedEvent = new MapCreatedEvent( type, this._map, this._homes );

            return event;
        }
    }

}
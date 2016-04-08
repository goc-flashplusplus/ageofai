/**
 * Created by newkrok on 08/04/16.
 */
package ageofai.map.view
{
    import ageofai.map.event.MapCreatedEvent;
    import ageofai.map.model.IMapModel;
    import ageofai.map.model.MapModel;
    import ageofai.map.model.MapNode;
	import common.mvc.view.base.ABaseMediator;

	public class MapMediator extends ABaseMediator
	{
		[Inject]
		public var view:MapView;
        
        [Inject]
        public var model:IMapModel;
        
		override public function initialize():void
		{
            if (this.model.map)
            {
                this.setViewMap(this.model.map);
            }
            
            this.addContextListener(MapCreatedEvent.MAP_CREATED, this.mapCreated);
		}
        
        private function mapCreated(e:MapCreatedEvent):void
        {
            this.setViewMap(e.map);
        }
        
        private function setViewMap(map:Vector.<Vector.<MapNode>>):void
        {
            this.view.createMap(map);
        }
	}
}
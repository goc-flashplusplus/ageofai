/**
 * Created by newkrok on 08/04/16.
 */
package ageofai.map.view
{
	import ageofai.map.event.MapCreatedEvent;
	import ageofai.map.model.IMapModel;
	import ageofai.map.vo.MapDataVO;
	import ageofai.villager.event.VillagerEvent;

	import common.mvc.view.base.ABaseMediator;

	public class MapMediator extends ABaseMediator
	{
		[Inject]
		public var view:MapView;

		[Inject]
		public var model:IMapModel;

		override public function initialize():void
		{
			if( this.model.map )
			{
				this.setViewMap( this.model.getMapData() );
			}

			this.addContextListener( MapCreatedEvent.MAP_CREATED, this.mapCreated );
			this.addContextListener( VillagerEvent.VILLAGER_CREATED, this.addVillager );
		}

		private function mapCreated( e:MapCreatedEvent ):void
		{
			this.setViewMap( e.mapData );
		}

		private function setViewMap( mapData:MapDataVO ):void
		{
			this.view.createMap( mapData );
		}

		private function addVillager( e:VillagerEvent ):void
		{
			trace(e.homeVO.id)
			this.view.addUnit( e.villager, e.homeVO.pos );
		}
	}
}
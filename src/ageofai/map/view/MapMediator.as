/**
 * Created by newkrok on 08/04/16.
 */
package ageofai.map.view
{
	import ageofai.forest.event.ForestEvent;
	import ageofai.forest.event.ForestViewEvent;
	import ageofai.forest.model.IForestModel;
	import ageofai.fruit.event.FruitEvent;
	import ageofai.fruit.event.FruitViewEvent;
	import ageofai.fruit.model.IFruitModel;
	import ageofai.fruit.vo.FruitVO;
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

		[Inject]
		public var fruitModel:IFruitModel;

		//[Inject]
		//public var forestModel:IForestModel;

		override public function initialize():void
		{
			if( this.model.map )
			{
				this.setViewMap( this.model.getMapData() );
			}


		}

		private function mapCreated( e:MapCreatedEvent ):void
		{
			this.setViewMap( e.mapData );
		}

		private function setViewMap( mapData:MapDataVO ):void
		{
			this.addContextListener( MapCreatedEvent.MAP_CREATED, this.mapCreated );
			this.addContextListener( VillagerEvent.VILLAGER_CREATED, this.addVillager );

			this.addViewListener( FruitViewEvent.FRUIT_CREATED, this.addFruit );
			this.addViewListener( ForestViewEvent.FOREST_CREATED, this.addForest );

			this.view.createMap( mapData );
		}

		private function addVillager( e:VillagerEvent ):void
		{
			this.view.addUnit( e.villager, e.homeVO.pos );
		}

		private function addFruit( e:FruitViewEvent ):void
		{
			this.fruitModel.addFruit( e.fruitVO );
		}

		private function addForest( e:ForestViewEvent ):void
		{
			//this.forestModel.addForest( e.forestVO );
		}
	}
}
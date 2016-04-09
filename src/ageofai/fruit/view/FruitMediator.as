/**
 * Created by newkrok on 09/04/16.
 */
package ageofai.fruit.view
{
	import ageofai.fruit.event.FruitEvent;
	import ageofai.fruit.event.FruitViewEvent;
	import ageofai.fruit.model.IFruitModel;
	import ageofai.fruit.vo.FruitVO;
	import ageofai.map.constant.CMap;
	import ageofai.map.model.IMapModel;
	import ageofai.villager.event.VillagerEvent;

	import common.mvc.view.base.ABaseMediator;

	import flash.geom.Point;

	public class FruitMediator extends ABaseMediator
	{
		[Inject]
		public var view:FruitView;

		[Inject]
		public var model:IFruitModel;

		[Inject]
		public var mapModel:IMapModel;

		override public function initialize():void
		{
			this.addViewListener( FruitViewEvent.FRUIT_CREATED, this.addFruit );

			this.addContextListener( FruitEvent.FRUIT_AMOUNT_UPDATED, this.fruitAmountUpdatedHandler );
			this.addContextListener( FruitEvent.FRUIT_RUN_OUT, this.forestRunOutHandler );
			this.addContextListener( VillagerEvent.VILLAGER_HARVEST, this.villagerHarvestHandler );
		}

		private function addFruit( e:FruitViewEvent ):void
		{
			this.model.addFruit(e.fruitVO);
		}

		private function fruitAmountUpdatedHandler( e:FruitEvent ):void
		{
			this.view.updateAmount( e.valueAmount );
		}

		private function forestRunOutHandler( e:FruitEvent ):void
		{
			this.view.destroy();
		}

		private function villagerHarvestHandler( event:VillagerEvent):void
		{
			var villagerPosition:Point = new Point();
			villagerPosition.x = event.villager.position.x;
			villagerPosition.y = event.villager.position.y;

			var fruits:Vector.<FruitVO> = this.mapModel.fruits;
			var l:int = fruits.length;
			for ( var i:int = 0; i < l; i++ )
			{
				var fruit:FruitVO = fruits[i];
				if ( fruit.pos.x == villagerPosition.x && fruit.pos.y == villagerPosition.y )
				{
					trace("mmmmmm ", fruit.amount)
					this.view.updateAmount( fruit.amount );
				}
			}

			//if ( this.view != event.fruitVO.view ) return;

		}
	}
}
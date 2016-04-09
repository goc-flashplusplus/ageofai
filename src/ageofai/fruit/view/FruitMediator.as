/**
 * Created by newkrok on 09/04/16.
 */
package ageofai.fruit.view
{
	import ageofai.fruit.event.FruitEvent;
	import ageofai.fruit.model.IFruitModel;
	import ageofai.villager.event.VillagerEvent;

	import common.mvc.view.base.ABaseMediator;

	public class FruitMediator extends ABaseMediator
	{
		[Inject]
		public var view:FruitView;

		[Inject]
		public var model:IFruitModel;

		override public function initialize():void
		{
			this.addContextListener( FruitEvent.FRUIT_AMOUNT_UPDATED, this.fruitAmountUpdatedHandler );
			this.addContextListener( FruitEvent.FRUIT_RUN_OUT, this.forestRunOutHandler );
			this.addContextListener( VillagerEvent.VILLAGER_HARVEST, this.villagerHarvestHandler );
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
			if ( this.view != event.fruitVO.view ) return;

			this.view.updateAmount( this.view.fruitVO.amount );
		}
	}
}
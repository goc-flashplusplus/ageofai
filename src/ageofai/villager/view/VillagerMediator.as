package ageofai.villager.view 
{
	import ageofai.villager.event.VillagerEvent;
	import common.mvc.view.base.ABaseMediator;
	/**
	 * ...
	 * @author Tibor Túri
	 */
	public class VillagerMediator extends ABaseMediator
	{
		
		[Inject]
		public var view:VillagerView;
		
		override public function initialize () : void
		{
			this.addContextListener( VillagerEvent.VILLAGER_HARVEST, this.villagerHarvestHandler);
			this.addContextListener( VillagerEvent.VILLAGER_ARRIWED_HOME, this.arriwedHomeHandler);
		}
		
		private function villagerHarvestHandler():void
		{
			this.view.showHarvestAnimation();
		}
		
		private function arriwedHomeHandler():void
		{
			this.view.showArriwedHomeAnimation();
		}
		
	}

}
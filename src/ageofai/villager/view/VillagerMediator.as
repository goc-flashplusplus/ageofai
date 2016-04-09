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
		}
		
		private function villagerHarvestHandler():void
		{
			this.view.showHarvestAnimation();
		}
		
	}

}
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
			this.addContextListener( VillagerEvent.VILLAGER_MOVE, this.villagerMove);
		}
		
		private function villagerHarvestHandler( event:VillagerEvent ):void
		{
			this.view.showHarvestAnimation( event.villager );
		}
		
		private function arriwedHomeHandler():void
		{
			this.view.showArriwedHomeAnimation();
		}
        
        private function villagerMove( event:VillagerEvent ):void
        {
            this.view.moveTo( event.villager );
        }
		
	}

}
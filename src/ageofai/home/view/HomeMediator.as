/**
 * Created by newkrok on 08/04/16.
 */
package ageofai.home.view
{
	import ageofai.home.event.HomeEvent;
	import common.mvc.view.base.ABaseMediator;

	public class HomeMediator extends ABaseMediator
	{
		[Inject]
		public var view:HomeView;

		override public function initialize():void
		{
			this.addContextListener( HomeEvent.VILLAGER_CREATED, this.villagerCredatedEventHandler);
			this.addContextListener( HomeEvent.VILLAGER_CREATION_IN_PROGRESS, this.villagerCreatedEventHandler );
		}
		
		private function villagerCredatedEventHandler():void
		{
			
		}
		private function villagerCreatedEventHandler():void
		{
			
		}
	}
}
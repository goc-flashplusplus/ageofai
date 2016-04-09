/**
 * Created by newkrok on 08/04/16.
 */
package ageofai.home.view
{
	import ageofai.home.event.HomeEvent;
	import ageofai.home.view.event.HomeViewEvent;
	import ageofai.villager.view.VillagerView;
	import common.mvc.view.base.ABaseMediator;

	public class HomeMediator extends ABaseMediator
	{
		[Inject]
		public var view:HomeView;

		override public function initialize():void
		{
			this.addContextListener( HomeEvent.REQUEST_TO_CREATE_VILLAGER, this.villagerCredatedEventHandler);
			this.addContextListener( HomeEvent.VILLAGER_CREATION_IN_PROGRESS, this.villagerCreatingInProgressEventHandler );
			
			this.addViewListener( HomeViewEvent.VILLAGER_VIEW_CREATED, this.villageViewCreatedHandler);
		}
		
		private function villageViewCreatedHandler( e:HomeViewEvent ):void
		{
            var homeEvent:HomeEvent = new HomeEvent( HomeEvent.VILLAGER_VIEW_CREATED );
            homeEvent.villagerView = e.villagerView;
			homeEvent.homeVO = e.homeVO;
            this.dispatch( homeEvent );
		}
		private function villagerCredatedEventHandler( e:HomeEvent ):void
		{
			this.view.createVillagerView( );			
		}
		private function villagerCreatingInProgressEventHandler( e:HomeEvent ):void
		{
			this.view.showProgressValue( e.progressPercentage / 100);
		}
	}
}
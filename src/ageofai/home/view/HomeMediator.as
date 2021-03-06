/**
 * Created by newkrok on 08/04/16.
 */
package ageofai.home.view
{
    import ageofai.home.event.HomeEvent;
    import ageofai.home.view.event.HomeViewEvent;

    import common.mvc.view.base.ABaseMediator;

    public class HomeMediator extends ABaseMediator
    {
        [Inject]
        public var view:HomeView;

        override public function initialize():void
        {
            this.addContextListener( HomeEvent.REQUEST_TO_CREATE_VILLAGER, this.villagerCredatedEventHandler );
            this.addContextListener( HomeEvent.VILLAGER_CREATION_IN_PROGRESS, this.villagerCreatingInProgressEventHandler );
            this.addContextListener( HomeEvent.FOOD_AMOUNT_UPDATED, this.foodAmountUpdatedHandler );
            this.addContextListener( HomeEvent.WOOD_AMOUNT_UPDATED, this.woodAmountUpdatedHandler );

            this.addViewListener( HomeViewEvent.VILLAGER_VIEW_CREATED, this.villageViewCreatedHandler );
        }

        private function villageViewCreatedHandler( e:HomeViewEvent ):void
        {
            if (e.homeVO.id != this.view.id) return;
            
            var homeEvent:HomeEvent = new HomeEvent( HomeEvent.VILLAGER_VIEW_CREATED );
            homeEvent.villagerView = e.villagerView;
            homeEvent.homeVO = e.homeVO;

            this.dispatch( homeEvent );
        }

        private function villagerCredatedEventHandler( e:HomeEvent ):void
        {
            if (e.homeVO.id != this.view.id) return;
            
            this.view.createVillagerView( e.homeVO );
        }

        private function villagerCreatingInProgressEventHandler( e:HomeEvent ):void
        {
            if (e.homeVO.id != this.view.id) return;
            
            this.view.showProgressValue( e.progressPercentage / 100 );
        }

        private function foodAmountUpdatedHandler( event:HomeEvent ):void
        {
            if (event.homeVO.id != this.view.id) return;
            
            this.view.updateFoodAmount( event.homeVO.food );
        }

        private function woodAmountUpdatedHandler( event:HomeEvent ):void
        {
            if (event.homeVO.id != this.view.id) return;
            
            this.view.updateWoodAmount( event.homeVO.wood );
        }
    }
}
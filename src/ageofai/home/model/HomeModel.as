/**
 * Created by vizoli on 4/9/16.
 */
package ageofai.home.model
{
    import ageofai.cost.constant.CUnitCost;
    import ageofai.home.ai.HomeAI;
    import ageofai.home.constant.CHome;
    import ageofai.home.event.HomeEvent;
    import ageofai.home.vo.HomeVO;

    import common.mvc.model.base.BaseModel;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    public class HomeModel extends BaseModel implements IHomeModel
    {
        private var _homes:Vector.<HomeVO>;
        private var _homeAI:HomeAI;
        private var _creatingInProgress:Boolean;
        private var _creationTimer:Timer;

        public function HomeModel()
        {
            this._homeAI = new HomeAI();

            this._creationTimer = new Timer( CHome.VILLAGER_CREATION_TIME / CHome.VILLAGER_CREATION_TIMELY, CHome.VILLAGER_CREATION_TIMELY );
            this._creationTimer.addEventListener( TimerEvent.TIMER, this.creationTimerHandler );
            this._creationTimer.addEventListener( TimerEvent.TIMER_COMPLETE, this.creationTimerCompleteHandler );
        }

        public function tick():void
        {
            this.calculateVillagerCreation();
        }

        private function calculateVillagerCreation():void
        {
            for ( var i:int = 0; i < this._homes.length; i++ )
            {
                if ( !this._creatingInProgress )
                {
                    if ( this._homeAI.isNewVillagerAvailable( this._homes[ i ].food, this._homes[ i ].villagerAmount ) )
                    {
                        this._creatingInProgress = true;

                        this._homes[ i ].food -= CUnitCost.VILLAGER.food;

                        this._creationTimer.start();
                    }
                }
            }
        }

        private function creationTimerHandler( event:TimerEvent ):void
        {
            var homeEvent:HomeEvent = new HomeEvent( HomeEvent.VILLAGER_CREATION_IN_PROGRESS );
            homeEvent.progressPercentage = this._creationTimer.currentCount * CHome.VILLAGER_CREATION_TIMELY;

            this.dispatch( homeEvent );
        }

        private function creationTimerCompleteHandler( event:TimerEvent ):void
        {
            this._creatingInProgress = false;

            var homeEvent:HomeEvent = new HomeEvent( HomeEvent.REQUEST_TO_CREATE_VILLAGER );
            homeEvent.homeId = 1

            this.dispatch( homeEvent );
        }

        public function setInitHomes( homes:Vector.<HomeVO> ):void
        {
            this._homes = homes;
        }
    }
}

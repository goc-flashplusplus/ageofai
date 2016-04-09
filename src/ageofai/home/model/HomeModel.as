/**
 * Created by vizoli on 4/9/16.
 */
package ageofai.home.model
{
    import ageofai.home.ai.HomeAI;
    import ageofai.home.constant.CHome;
    import ageofai.home.event.HomeEvent;

    import common.mvc.model.base.BaseModel;

    import flash.events.TimerEvent;

    import flash.utils.Timer;

    public class HomeModel extends BaseModel implements IHomeModel
    {
        private var _foodAmount:int;
        private var _villagerAmount:int;
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
            if ( !this._creatingInProgress )
            {
                if ( this._homeAI.isNewVillagerAvailable( this._foodAmount, this._villagerAmount ) )
                {
                    this._creatingInProgress = true;

                    this._creationTimer.start();
                }
            }
        }

        public function setFoodAmount( value:int ):void
        {
            this._foodAmount = value;
        }

        public function setVillagerAmount( value:int ):void
        {
            this._villagerAmount = value;
        }

        private function creationTimerHandler( event:TimerEvent ):void
        {
            var homeEvent:HomeEvent = new HomeEvent( HomeEvent.VILLAGER_CREATION_IN_PROGRESS );
            homeEvent.progressPercentage = this._creationTimer.currentCount * CHome.VILLAGER_CREATION_TIMELY;

            this.dispatch( homeEvent );
        }

        private function creationTimerCompleteHandler( event:TimerEvent ):void
        {
            this.dispatch( new HomeEvent( HomeEvent.VILLAGER_CREATED ) );
        }
    }
}

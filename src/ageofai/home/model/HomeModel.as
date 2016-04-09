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
    import ageofai.villager.vo.VillagerVO;

    import common.mvc.model.base.BaseModel;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    public class HomeModel extends BaseModel implements IHomeModel
    {
        private var _homes:Vector.<HomeVO>;
        private var _homeAI:HomeAI;

        public function HomeModel()
        {
            this._homeAI = new HomeAI();
        }

        public function tick():void
        {
            this.calculateVillagerCreation();
        }

        private function calculateVillagerCreation():void
        {
            for ( var i:int = 0; i < this._homes.length; i++ )
            {
                if ( !this._homes[ i ].villagerIsCreating )
                {
                    if ( this._homeAI.isNewVillagerAvailable( this._homes[ i ].food, this._homes[ i ].villagers.length ) )
                    {
                        this._homes[ i ].villagerIsCreating = true;

                        this._homes[ i ].food -= CUnitCost.VILLAGER.food;

                        var home:HomeVO = this._homes[ i ]

                        var creationTimer:Timer = new Timer( CHome.VILLAGER_CREATION_TIME / CHome.VILLAGER_CREATION_TIMELY, CHome.VILLAGER_CREATION_TIMELY );
                        creationTimer.addEventListener( TimerEvent.TIMER, function ():void
                        {
                            creationTimerHandler( creationTimer, home );
                        });
                        creationTimer.addEventListener( TimerEvent.TIMER_COMPLETE, function ():void
                        {
                            creationTimerCompleteHandler( creationTimer, home );
                        });

                        creationTimer.start();
                    }
                }
            }
        }

        private function creationTimerHandler( creationTimer:Timer, homeVO:HomeVO ):void
        {
            var homeEvent:HomeEvent = new HomeEvent( HomeEvent.VILLAGER_CREATION_IN_PROGRESS );
            homeEvent.progressPercentage = creationTimer.currentCount * CHome.VILLAGER_CREATION_TIMELY;

            this.dispatch( homeEvent );
        }

        private function creationTimerCompleteHandler( creationTimer:Timer, homeVO:HomeVO ):void
        {
            homeVO.villagerIsCreating = false;

            var homeEvent:HomeEvent = new HomeEvent( HomeEvent.REQUEST_TO_CREATE_VILLAGER );
            homeEvent.homeVO = homeVO;

            this.dispatch( homeEvent );
        }

        public function setInitHomes( homes:Vector.<HomeVO> ):void
        {
            this._homes = homes;
        }

        public function addVillager( homeVO:HomeVO, villagerVO:VillagerVO ):void
        {
            homeVO.villagers.push( villagerVO );
        }

        public function updateFoodAmount( homeVO:HomeVO, amount:int ):void
        {
        }

        public function updateWoodAmount( homeVO:HomeVO, amount:int ):void
        {
        }
    }
}

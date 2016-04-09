/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.villager.model
{
    import ageofai.home.vo.HomeVO;
    import ageofai.map.geom.IntPoint;
    import ageofai.villager.constant.CVillagerStatus;
    import ageofai.villager.event.VillagerEvent;
    import ageofai.villager.vo.VillagerVO;

    import common.mvc.model.base.BaseModel;

    public class VillagerModel extends BaseModel implements IVillagerModel
    {
        private var _villagers:Vector.<VillagerVO>;

        public function VillagerModel()
        {
            this._villagers = new <VillagerVO>[];
        }

        public function getVillagers():Vector.<VillagerVO>
        {
            return this._villagers;
        }

        public function addVillager( villagerVO:VillagerVO, pos:IntPoint ):void
        {
            this._villagers.push( villagerVO );

            var homeVO:HomeVO = new HomeVO();
            homeVO.pos = pos;

            var villagarEvent:VillagerEvent = new VillagerEvent( VillagerEvent.VILLAGER_CREATED );
            villagarEvent.villager = villagerVO;

            villagarEvent.homeVO = homeVO;

            this.dispatch( villagarEvent );
        }

        public function tick():void
        {
            this.calculateMovements();
        }
        
        
        public function moveVillagerTo(villager:VillagerVO, newPos:IntPoint):void 
        {
            var ve:VillagerEvent = new VillagerEvent(VillagerEvent.VILLAGER_MOVE);
            ve.villager = villager;
            ve.position = newPos;
            villager.position = newPos;

            this.dispatch( ve );
        }

        private function calculateMovements():void
        {
            var event:VillagerEvent;
            var eventType:String;
			
			var dispatchStatus:Boolean;

            for ( var i:int = 0; i < this._villagers.length; i++ )
            {
                switch ( this._villagers[ i ].status )
                {
                    case CVillagerStatus.IDLE:
						dispatchStatus = true;
                        eventType = VillagerEvent.REQUEST_TO_MOVE_RANDOM;

                        break;

                    case CVillagerStatus.HARVEST:
						dispatchStatus = statusChanged(this._villagers[ i ]);
                        eventType = VillagerEvent.VILLAGER_HARVEST;

                        break;

                    case CVillagerStatus.WOOD_CUTTING:
						dispatchStatus = true;
                        eventType = VillagerEvent.REQUEST_TO_MOVE_BACK_TO_WORK;

                        break;

                    default:
                        throw new Error( "What this fucking villager is doing? :D" );
                }
				
				this._villagers[ i ].previousStatus = this._villagers[ i ].status;
				
				if ( dispatchStatus )
				{
					event = new VillagerEvent( eventType );
					event.villager = this._villagers[ i ];
					this.dispatch( event );
				}
				
            }
        }
		
		private function statusChanged( villager:VillagerVO ):Boolean
		{
			return villager.previousStatus == villager.status ? false : true;
		}
    }
}
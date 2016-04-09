/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.villager.model
{
    import ageofai.home.vo.HomeVO;
    import ageofai.map.geom.IntPoint;
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

<<<<<<< HEAD
        public function addVillager( villagerVO:VillagerVO, pos:IntPoint ):void
=======
        public function addVillager( unit:IUnitView, homeVO:HomeVO ):void
>>>>>>> origin/master
        {
            this._villagers.push( villagerVO );

            var villagarEvent:VillagerEvent = new VillagerEvent( VillagerEvent.VILLAGER_CREATED );
<<<<<<< HEAD
            villagarEvent.villager = villagerVO;

            var homeVO:HomeVO = new HomeVO();
            homeVO.pos = pos;

=======
            villagarEvent.villager = unit as VillagerView;
>>>>>>> origin/master
            villagarEvent.homeVO = homeVO;

            this.dispatch( villagarEvent );
        }

        public function tick():void
        {
        }
    }
}
/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.villager.model
{
    import ageofai.home.vo.HomeVO;
    import ageofai.map.geom.IntPoint;
    import ageofai.unit.base.IUnitView;
    import ageofai.villager.event.VillagerEvent;
    import ageofai.villager.view.VillagerView;

    import common.mvc.model.base.BaseModel;

    public class VillagerModel extends BaseModel implements IVillagerModel
    {
        private var _villagers:Vector.<IUnitView>;

        public function VillagerModel()
        {
            this._villagers = new <IUnitView>[];
        }

        public function getVillagers():Vector.<IUnitView>
        {
            return this._villagers;
        }

        public function addVillager( unit:IUnitView, homeVO:HomeVO ):void
        {
            this._villagers.push( unit );

            var villagarEvent:VillagerEvent = new VillagerEvent( VillagerEvent.VILLAGER_CREATED );
            villagarEvent.villager = unit as VillagerView;
            villagarEvent.homeVO = homeVO;

            this.dispatch( villagarEvent );
        }
    }
}
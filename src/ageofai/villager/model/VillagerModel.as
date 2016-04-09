/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.villager.model
{
    import ageofai.unit.base.IUnitView;

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

        public function addVillager( unit:IUnitView ):void
        {
            this._villagers.push( unit );
        }
    }
}

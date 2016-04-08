/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.villager.model
{
    import ageofai.unit.base.IUnitView;

    import common.mvc.model.base.BaseModel;

    public class VillagerModel extends BaseModel implements IVillagerModel
    {
        private var _units:Vector.<IUnitView>;

        public function getVillagers():Vector.<IUnitView>
        {
            return this._units;
        }

        public function addVillager( unit:IUnitView ):void
        {
            this._units.push( unit );
        }

        public function getUnits():Vector.<IUnitView>
        {
            return null;
        }

        public function addUnit( unit:IUnitView ):void
        {
        }
    }
}

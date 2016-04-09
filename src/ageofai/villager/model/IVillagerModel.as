/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.villager.model
{
    import ageofai.map.geom.IntPoint;
    import ageofai.unit.base.IUnitView;

    public interface IVillagerModel
    {

        function getVillagers():Vector.<IUnitView>;

        function addVillager( unit:IUnitView, pos:IntPoint ):void;

    }
}
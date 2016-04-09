/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.villager.model
{
    import ageofai.map.geom.IntPoint;
    import ageofai.villager.vo.VillagerVO;

    public interface IVillagerModel
    {

        function tick():void;

        function getVillagers():Vector.<VillagerVO>;

        function addVillager( villagerVO:VillagerVO, pos:IntPoint ):void;
        
        function moveVillagerTo( villager:VillagerVO, newPos:IntPoint ):void;

    }
}
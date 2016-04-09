/**
 * Created by vizoli on 4/9/16.
 */
package ageofai.home.model
{
    import ageofai.home.vo.HomeVO;
    import ageofai.villager.vo.VillagerVO;

    public interface IHomeModel
    {

        function tick():void;

        function setInitHomes( homes:Vector.<HomeVO> ):void;

        function addVillager( homeVO:HomeVO, villagerVO:VillagerVO ):void;

    }
}

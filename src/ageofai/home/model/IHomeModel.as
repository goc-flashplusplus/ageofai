/**
 * Created by vizoli on 4/9/16.
 */
package ageofai.home.model
{
    import ageofai.home.vo.HomeVO;

    public interface IHomeModel
    {

        function tick():void;

        function setFoodAmount( value:int ):void;

        function setVillagerAmount( value:int ):void;

        function setInitHomes( homes:Vector.<HomeVO> ):void;

    }
}

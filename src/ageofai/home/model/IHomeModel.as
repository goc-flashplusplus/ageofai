/**
 * Created by vizoli on 4/9/16.
 */
package ageofai.home.model
{
    public interface IHomeModel
    {

        function tick():void;

        function setFoodAmount( value:int ):void;

        function setVillagerAmount( value:int ):void;

    }
}

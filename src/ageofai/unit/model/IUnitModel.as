/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.unit.model
{
    import ageofai.unit.base.IUnitView;

    public interface IUnitModel
    {

        function getUnits():Vector.<IUnitView>;

        function addUnit(unit:IUnitView):void;

    }
}

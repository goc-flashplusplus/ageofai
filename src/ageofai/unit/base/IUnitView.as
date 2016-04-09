/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.unit.base
{
    import ageofai.unit.vo.UnitVO;

    import flash.geom.Point;

    public interface IUnitView
    {

        function moveTo( villagerVO:UnitVO ):void;

        function calculateMovingTime( point:Point ):Number;

    }
}

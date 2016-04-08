/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.unit.base
{
    import flash.geom.Point;

    public interface IUnitView
    {

        function moveTo( targetPoint:Point ):void;

        function calculateMovingTime( point:Point):Number;

    }
}

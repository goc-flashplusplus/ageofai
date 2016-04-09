/**
 * Created by vizoli on 4/9/16.
 */
package ageofai.unit.vo
{
    import ageofai.map.geom.IntPoint;
    import ageofai.unit.base.IUnitView;

    public class UnitVO
    {

        public var previousStatus:String;
        public var status:String;
        public var view:IUnitView;
        public var position:IntPoint;
        public var destination:DestinationDataVO;

    }
}

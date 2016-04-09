/**
 * Created by vizoli on 4/9/16.
 */
package ageofai.villager.vo
{
    import ageofai.map.geom.IntPoint;
    import ageofai.unit.base.IUnitView;
    import ageofai.unit.vo.DestinationDataVO;
    import ageofai.villager.constant.CVillagerStatus;

    public class VillagerVO
    {

        public var status:String = CVillagerStatus.IDLE;
        public var view:IUnitView;
        public var position:IntPoint;
        public var destination:DestinationDataVO;

    }
}

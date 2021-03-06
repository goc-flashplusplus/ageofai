/**
 * Created by vizoli on 4/9/16.
 */
package ageofai.villager.controller
{
    import ageofai.home.model.IHomeModel;
    import ageofai.home.vo.HomeVO;
    import ageofai.map.geom.IntPoint;
    import ageofai.map.model.IMapModel;
    import ageofai.unit.utils.VillagerAI;
    import ageofai.villager.event.VillagerEvent;
    import ageofai.villager.model.IVillagerModel;
    import ageofai.villager.vo.VillagerVO;
    import common.mvc.controller.base.BaseCommand;

    public class StartRandomVillagerMovementCommand extends BaseCommand
    {
        [Inject]
        public var mapModel:IMapModel;
        
        [Inject]
        public var homeModel:IHomeModel;
        
        [Inject]
        public var villagerModel:IVillagerModel;
        
        [Inject]
        public var event:VillagerEvent;

        override public function execute():void
        {
            var villagerAI:VillagerAI = new VillagerAI();
            var newPos:IntPoint = villagerAI.tick(event.villager, mapModel, homeModel.getHomeByVillager(event.villager));
            if (newPos != null)
            {
                villagerModel.moveVillagerTo( event.villager, newPos );
            }
        }
    }
}

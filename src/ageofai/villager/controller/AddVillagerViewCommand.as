/**
 * Created by vizoli on 4/9/16.
 */
package ageofai.villager.controller
{
    import ageofai.home.event.HomeEvent;
    import ageofai.home.model.IHomeModel;
    import ageofai.villager.model.IVillagerModel;
    import ageofai.villager.vo.VillagerVO;

    import common.mvc.controller.base.BaseCommand;

    public class AddVillagerViewCommand extends BaseCommand
    {
        [Inject]
        public var villagerModel:IVillagerModel;

        [Inject]
        public var homeModel:IHomeModel;

        [Inject]
        public var event:HomeEvent;

        override public function execute():void
        {
            var villagerVO:VillagerVO = new VillagerVO();
            villagerVO.view = this.event.villagerView;
            villagerVO.position = event.homeVO.pos;

            this.villagerModel.addVillager( villagerVO, event.homeVO.pos );

            this.homeModel.addVillager( this.event.homeVO, villagerVO );
        }
    }
}

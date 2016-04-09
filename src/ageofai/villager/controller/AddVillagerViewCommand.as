/**
 * Created by vizoli on 4/9/16.
 */
package ageofai.villager.controller
{
    import ageofai.home.event.HomeEvent;
    import ageofai.villager.model.IVillagerModel;

    import common.mvc.controller.base.BaseCommand;

    public class AddVillagerViewCommand extends BaseCommand
    {
        [Inject]
        public var villagerModel:IVillagerModel;

        [Inject]
        public var event:HomeEvent;

        override public function execute():void
        {
            this.villagerModel.addVillager( this.event.villagerView );
        }
    }
}

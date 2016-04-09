/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.game.controller
{
    import ageofai.building.model.IBuildingModel;
    import ageofai.home.model.IHomeModel;

    import common.mvc.controller.base.BaseCommand;

    public class ProcessTickCommand extends BaseCommand
    {
        [Inject]
        public var buildingModel:IBuildingModel;

        [Inject]
        public var homeModel:IHomeModel;

        override public function execute():void
        {
            this.buildingModel.tick();
            this.homeModel.tick();
        }
    }
}

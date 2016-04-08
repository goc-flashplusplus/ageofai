/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.game.controller
{
    import ageofai.building.model.IBuildingModel;

    import common.mvc.controller.base.BaseCommand;

    public class ProcessTickCommand extends BaseCommand
    {
        [Inject]
        public var buildingModel:IBuildingModel;

        override public function execute():void
        {
            this.buildingModel.tick();
        }
    }
}

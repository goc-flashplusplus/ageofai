/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.home.controller
{
    import ageofai.game.model.IGameModel;
    import ageofai.home.model.IHomeModel;

    import common.mvc.controller.base.BaseCommand;

    public class SetInitHomesCommand extends BaseCommand
    {
        [Inject]
        public var homeModel:IHomeModel;

        override public function execute():void
        {
            this.homeModel.
        }
    }
}

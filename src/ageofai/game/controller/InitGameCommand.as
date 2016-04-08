/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.game.controller
{
    import ageofai.game.model.IGameModel;

    import common.mvc.controller.base.BaseCommand;

    public class InitGameCommand extends BaseCommand
    {
        [Inject]
        public var gameModel:IGameModel;

        override public function execute():void
        {
            this.gameModel.init();
        }
    }
}

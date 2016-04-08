/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.game.controller
{
    import ageofai.map.constant.CMap;
    import ageofai.map.model.IMapModel;

    import common.mvc.controller.base.BaseCommand;

    public class CreateMapCommand extends BaseCommand
    {
        [Inject]
        public var mapModel:IMapModel;

        override public function execute():void
        {
            this.mapModel.createMap( CMap.ROW_COUNT, CMap.COLUMN_COUNT );
        }
    }
}

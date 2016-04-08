/**
 * Created by vizoli on 4/9/16.
 */
package ageofai.game.model
{
    import ageofai.game.constant.CGame;

    import common.mvc.model.BaseModel;

    import flash.events.TimerEvent;

    import flash.utils.Timer;

    public class GameModel extends BaseModel implements IGameModel
    {
        private var _tick:Timer;

        public function GameModel()
        {
            this._tick = new Timer( CGame.TICK_TIME );
            this._tick.addEventListener( TimerEvent.TIMER, this.tickHandler );
        }

        public function init():void
        {
            this._tick.start();
        }

        private function tickHandler( event:TimerEvent ):void
        {
            trace("ddddd")
        }
    }
}

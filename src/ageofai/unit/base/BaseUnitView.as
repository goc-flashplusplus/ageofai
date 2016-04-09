package ageofai.unit.base
{
    import ageofai.map.constant.CMap;
    import ageofai.unit.view.LifeBarView;
    import ageofai.unit.vo.UnitVO;

    import caurina.transitions.Tweener;

    import common.mvc.view.base.ABaseView;
    import common.utils.MathUtil;

    import flash.display.DisplayObject;
    import flash.geom.Point;

    /**
     * ...
     * @author Tibor Túri
     */
    public class BaseUnitView extends ABaseView implements IUnitView
    {

        public var speed:Number;

        private var _graphicUI:DisplayObject;
        public var lifebar:LifeBarView;
        public var unitVO:UnitVO;

        public function BaseUnitView()
        {

        }

        protected function createUI( uiClass:Class ):void
        {
            this._graphicUI = new uiClass;
            this.addChild( this._graphicUI );

            this._graphicUI.x = CMap.TILE_SIZE / 2;
            this._graphicUI.y = CMap.TILE_SIZE / 2;
        }

        public function createLifeBar():void
        {
            this.lifebar = new LifeBarView();
            this.addChild( this.lifebar );

            this.lifebar.x = ( CMap.TILE_SIZE - this.lifebar.barWidth ) / 2;
            this.lifebar.y = -30;
            this.lifebar.drawProcessBar( 1 );
        }

        public function moveTo( villagerVO:UnitVO ):void
        {
            if ( this == villagerVO.view )
            {
                var movingTime:Number = this.calculateMovingTime( new Point( villagerVO.position.x, villagerVO.position.y ) );
                Tweener.addTween( this, {
                    x: villagerVO.position.x,
                    y: villagerVO.position.y,
                    time: movingTime,
                    transition: "linear"
                } )
                this.calculateDirection( new Point( villagerVO.position.x, villagerVO.position.y ) );
            }
        }

        private function calculateDirection( targetPoint:Point ):void
        {
            var direction:Number = targetPoint.x > this.x ? 1 : -1;
            this._graphicUI.scaleX = direction;
        }

        public function calculateMovingTime( point:Point ):Number
        {
            var distance:Number;
            var movingTime:Number;
            var currentPosition:Point = this.getCurrentPosition();

            distance = MathUtil.distance( currentPosition.x, currentPosition.y, point.x, point.y );

            movingTime = Math.abs( distance ) / CMap.TILE_SIZE * this.speed;

            return movingTime;
        }

        private function getCurrentPosition():Point
        {
            return new Point( this.x, this.y );
        }

        public function get graphicUI():DisplayObject
        {
            return _graphicUI;
        }
    }

}
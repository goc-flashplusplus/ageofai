package ageofai.unit.base 
{
	import ageofai.bars.LifeBarView;
	import ageofai.map.constant.CMap;
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

		public function BaseUnitView() 
		{
			
		}

		protected function createUI( uiClass:Class ):void
		{
			this._graphicUI = new uiClass;
			this.addChild( this._graphicUI );
		}
		
		public function createLifeBar():void
		{
			this.lifebar = new LifeBarView();
			this.addChild( this.lifebar );
			
			this.lifebar.x = ( CMap.TILE_SIZE - this.lifebar.barWidth ) / 2 ;
			this.lifebar.y = 5;
		}
		
		public function moveTo( targetPoint:Point ):void
		{
			var movingTime:Number = this.calculateMovingTime( targetPoint );
			Tweener.addTween(this, {x: targetPoint.x, y:targetPoint.y, time: movingTime,  transition:"linear"  } );
		}
		
		public function calculateMovingTime( point:Point):Number
		{
			var distance:Number;
			var movingTime:Number;
			var currentPosition:Point = this.getCurrentPosition();
			
			distance = MathUtil.distance( currentPosition.x, currentPosition.y, point.x, point.y);
			
			movingTime = Math.abs(distance) / CMap.TILE_SIZE * this.speed;
			trace("3: ----", movingTime);
			return movingTime;			
		}
		
		private function getCurrentPosition():Point
		{
			return new Point( this.x, this.y);
		}
	}

}
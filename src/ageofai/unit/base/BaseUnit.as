package ageofai.unit.base 
{
	import caurina.transitions.Tweener;
	import common.mvc.view.base.ABaseView;
	import common.utils.MathUtil;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Tibor Túri
	 */
	public class BaseUnit extends ABaseView
	{
		
		public var speed:Number;
		
		public function BaseUnit() 
		{
			
		}
		
		public function moveTo( targetPoint:Point ):void
		{
			var movingTime:Number = this.calculateMovingTime( targetPoint );
			Tweener.addTween(this, {x: targetPoint.x, y:targetPoint.y, time: movingTime} );
		}
		
		public function calculateMovingTime( point:Point):Number
		{
			var distance:Number;
			var movingTime:Number;
			var currentPosition:Point = this.getCurrentPosition();
			
			distance = MathUtil.distance( currentPosition.x, currentPosition.y, point.x, point.y);
			
			movingTime = Math.abs(distance) / this.speed;
			
			return movingTime;			
		}
		
		private function getCurrentPosition():Point
		{
			return new Point( this.x, this.y);
		}
	}

}
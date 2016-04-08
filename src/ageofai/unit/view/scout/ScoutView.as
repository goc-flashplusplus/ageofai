package ageofai.unit.view.scout 
{
	import ageofai.map.constant.CMap;
	import ageofai.unit.base.BaseUnitView;
	import ageofai.unit.CUnitProperties;
	import flash.display.Shape;
	/**
	 * ...
	 * @author Tibor Túri
	 */
	public class ScoutView  extends BaseUnitView 
	{
		
		public function ScoutView() 
		{
			this.speed = CUnitProperties.SCOUT_SPEED;
			this.createChildren();			
		}
		
		override public function createChildren():void
		{
			var rectangle:Shape = new Shape; 
			rectangle.graphics.beginFill(0x00FF00);
			rectangle.graphics.drawRect(0, 0, CMap.TILE_SIZE,CMap.TILE_SIZE);
			rectangle.graphics.endFill();
			this.addChild(rectangle);			
		}		
		
	}

}
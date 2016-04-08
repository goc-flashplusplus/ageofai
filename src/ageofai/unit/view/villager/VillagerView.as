package ageofai.unit.view.villager 
{
	import ageofai.map.constant.CMap;
	import ageofai.unit.base.BaseUnit;
	import ageofai.unit.CUnitProperties;
	import flash.display.Shape;
	import caurina.transitions.Tweener;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Tibor Túri
	 */
	public class VillagerView extends BaseUnit
	{
		
		
		public function VillagerView() 
		{
			this.speed = CUnitProperties.VILLAGER_SPEED;
			this.createChildren();
		}
		
		
		override public function createChildren():void
		{
			var rectangle:Shape = new Shape; 
			rectangle.graphics.beginFill(0xFF0000);
			rectangle.graphics.drawRect(0, 0, CMap.TILE_SIZE,CMap.TILE_SIZE);
			rectangle.graphics.endFill();
			addChild(rectangle);			
		}
	}

}
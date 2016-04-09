/**
 * Created by newkrok on 09/04/16.
 */
package ageofai.fruit.vo
{
	import ageofai.constant.CCollectableValues;
	import ageofai.fruit.view.FruitView;
	import ageofai.map.geom.IntPoint;

	import flash.display.DisplayObject;

	public class FruitVO
	{
		public var id:int;
		public var view:FruitView;
		public var amount:int = CCollectableValues.FRUIT_AMOUNT_VALUE;
		public var pos:IntPoint;
	}
}

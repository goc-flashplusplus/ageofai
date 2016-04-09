/**
 * Created by newkrok on 09/04/16.
 */
package ageofai.fruit.vo
{
	import ageofai.constant.CCollectableValues;

	import flash.display.DisplayObject;

	public class FruitVO
	{
		public var id:int;
		public var view:DisplayObject;
		public var amount:int = CCollectableValues.FRUIT_AMOUNT_VALUE;
	}
}

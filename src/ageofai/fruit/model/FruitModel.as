/**
 * Created by newkrok on 09/04/16.
 */
package ageofai.fruit.model
{
	import ageofai.constant.CCollectableValues;
	import ageofai.fruit.event.FruitEvent;

	import common.mvc.model.base.BaseModel;

	public class FruitModel extends BaseModel implements IFruitModel
	{
		private var _remainValue:int = CCollectableValues.FRUIT_AMOUNT_VALUE;

		public function FruitModel()
		{
		}

		public function updateValueAmount( value:Number ):void
		{
			this._remainValue = value;

			if( value <= 0 )
			{
				var event:FruitEvent = new FruitEvent( FruitEvent.FRUIT_RUN_OUT );
			}
			else
			{
				event = new FruitEvent( FruitEvent.FRUIT_AMOUNT_UPDATED );
				event.valueAmount = value;
			}

			this.dispatch( event );
		}
	}
}
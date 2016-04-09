/**
 * Created by newkrok on 09/04/16.
 */
package ageofai.forest.model
{
	import ageofai.constant.CCollectableValues;
	import ageofai.forest.event.ForestEvent;

	import common.mvc.model.base.BaseModel;

	public class ForestModel extends BaseModel
	{
		private var _remainValue:int = CCollectableValues.FRUIT_AMOUNT_VALUE;

		public function ForestModel()
		{
		}

		public function updateValueAmount( value:Number ):void
		{
			this._remainValue = value;

			var event:ForestEvent = new ForestEvent( ForestEvent.FOREST_AMOUNT_UPDATED );
			event.valueAmount = value;

			this.dispatch( event );

			if( value <= 0 )
			{
				var event:ForestEvent = new ForestEvent( ForestEvent.FOREST_RUN_OUT );
			}
			else
			{
				event = new ForestEvent( ForestEvent.FOREST_AMOUNT_UPDATED );
				event.valueAmount = value;
			}

			this.dispatch( event );
		}
	}
}
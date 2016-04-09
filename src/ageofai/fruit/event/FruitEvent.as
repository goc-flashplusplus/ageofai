/**
 * Created by newkrok on 09/04/16.
 */
package ageofai.fruit.event
{
	import flash.events.Event;

	public class FruitEvent extends Event
	{
		public static const FRUIT_AMOUNT_UPDATED:String = 'FruitEvent.FRUIT_AMOUNT_UPDATED';
		public static const FRUIT_RUN_OUT:String = 'FruitEvent.FRUIT_RUN_OUT';

		public var valueAmount:Number;

		public function FruitEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			super( type, bubbles, cancelable );
		}

		override public function clone():Event
		{
			var event:FruitEvent = new FruitEvent( this.type, this.bubbles, this.cancelable );
			event.valueAmount = this.valueAmount;

			return event;
		}
	}
}
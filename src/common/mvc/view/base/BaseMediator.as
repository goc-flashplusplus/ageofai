package common.mvc.view.base
{
	import flash.events.Event;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * Base class for each mediators.
	 * 
	 * @author vizoli
	 */
	public class BaseMediator extends Mediator 
	{
		
		public function BaseMediator() 
		{
			
		}
		
		/**
		 * Forward the event.
		 * 
		 * @param	e
		 */
		protected function forwardEvent( e:Event ):void
		{
			this.dispatch( e );
		}
		
	}

}
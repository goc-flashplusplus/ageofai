/**
 * Created by newkrok on 09/04/16.
 */
package ageofai.forest.view
{
	import ageofai.forest.event.ForestEvent;
	import ageofai.forest.model.IForestModel;

	import common.mvc.view.base.ABaseMediator;

	public class ForestMediator extends ABaseMediator
	{
		[Inject]
		public var view:ForestView;

		[Inject]
		public var model:IForestModel;

		override public function initialize():void
		{
			this.addContextListener( ForestEvent.FOREST_AMOUNT_UPDATED, this.forestAmountUpdatedHandler );
			this.addContextListener( ForestEvent.FOREST_RUN_OUT, this.forestRunOutHandler );
		}

		private function forestAmountUpdatedHandler( e:ForestEvent ):void
		{
			this.view.updateAmount( e.valueAmount );
		}

		private function forestRunOutHandler( e:ForestEvent ):void
		{
			this.view.destroy();
		}
	}
}
/**
 * Created by newkrok on 09/04/16.
 */
package ageofai.forest.view
{
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

		}
	}
}
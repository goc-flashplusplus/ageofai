/**
 * Created by newkrok on 09/04/16.
 */
package ageofai.fruit.view
{
	import ageofai.fruit.model.IFruitModel;

	import common.mvc.view.base.ABaseMediator;

	public class FruitMediator extends ABaseMediator
	{
		[Inject]
		public var view:FruitView;

		[Inject]
		public var model:IFruitModel;

		override public function initialize():void
		{

		}
	}
}
/**
 * Created by newkrok on 08/04/16.
 */
package ageofai.building.view.home
{
	import flash.display.Sprite;

	public class HomeView extends Sprite
	{
		private var _graphicUI:HomeUI;

		public function HomeView()
		{
			this._graphicUI = new HomeUI();
			this.addChild( this._graphicUI );
		}
	}
}
/**
 * Created by newkrok on 09/04/16.
 */
package ageofai.building.base
{
	import ageofai.bars.LifeBarView;

	import flash.display.Sprite;

	public class BaseBuildingView extends Sprite
	{
		private var _graphicUI:HomeUI;
		private var _lifeBar:LifeBarView;

		public function BaseBuildingView()
		{
		}

		protected function createUI( uiClass:Class ):void
		{
			this._graphicUI = new uiClass;
			this.addChild( this._graphicUI );
		}

		protected function createLifeBar():void
		{
			this._lifeBar = new LifeBarView();
			this._lifeBar.width = this._graphicUI.width;

			this._lifeBar.drawProcessBar( Math.random() );

			this.addChild( this._lifeBar );
		}
	}
}
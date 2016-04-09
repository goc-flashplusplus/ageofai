/**
 * Created by newkrok on 09/04/16.
 */
package ageofai.fruit.view
{
	import ageofai.map.constant.CMap;
	import ageofai.unit.view.LifeBarView;

	import common.mvc.view.base.ABaseView;

	import flash.display.DisplayObject;

	public class FruitView extends ABaseView
	{
		private var _graphicUI:DisplayObject;
		private var _lifeBar:LifeBarView;

		public function FruitView()
		{
			this.createChildren();
		}

		override public function createChildren():void
		{
			this.createUI( FruitUI );
			this.createLifeBar();
		}

		protected function createUI( uiClass:Class ):void
		{
			this._graphicUI = new uiClass;
			this.addChild( this._graphicUI );

			this._graphicUI.x = CMap.TILE_SIZE / 2;
			this._graphicUI.y = CMap.TILE_SIZE / 2;
		}

		public function createLifeBar():void
		{
			this._lifeBar = new LifeBarView();
			this.addChild( this._lifeBar );

			this._lifeBar.x = ( CMap.TILE_SIZE - this._lifeBar.barWidth ) / 2 ;
			this._lifeBar.y = 5;
		}
	}
}
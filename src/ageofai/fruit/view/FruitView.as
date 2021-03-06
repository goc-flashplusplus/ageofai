/**
 * Created by newkrok on 09/04/16.
 */
package ageofai.fruit.view
{
	import ageofai.fruit.vo.FruitVO;
	import ageofai.map.constant.CMap;
	import ageofai.unit.view.LifeBarView;

	import common.mvc.view.base.ABaseView;

	import flash.display.DisplayObject;

	public class FruitView extends ABaseView
	{
		public var fruitVO:FruitVO;
		private var _graphicUI:DisplayObject;
		private var _lifeBar:LifeBarView;
		private var _lifeValueAmount:int;

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

			this._lifeBar.x = ( CMap.TILE_SIZE - this._lifeBar.barWidth ) / 2;
			this._lifeBar.y = -10;

			this._lifeBar.barWidth = 100;
			this._lifeBar.drawProcessBar( 1 );
		}

		public function updateAmount( valueAmount:int ):void
		{
			this._lifeValueAmount = valueAmount;

			this._lifeBar.drawProcessBar( this._lifeValueAmount / 100 );
		}

		public function destroy():void
		{
			if( this.parent )
			{
				this.parent.removeChild( this );
			}
		}
	}
}
/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.layout.view.view
{
	import ageofai.map.view.MapView;

	import common.mvc.view.base.ABaseView;

	public class LayoutView extends ABaseView
	{
		private var _mapView:MapView;

		public function LayoutView()
		{

		}

		override public function createChildren():void
		{
			this._mapView = new MapView();
			this.addChild( this._mapView );
		}
	}
}
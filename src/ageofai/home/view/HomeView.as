/**
 * Created by newkrok on 08/04/16.
 */
package ageofai.home.view
{
	import ageofai.building.base.BaseBuildingView;
<<<<<<< Updated upstream
	import ageofai.home.view.event.HomeViewEvent;
	import ageofai.villager.event.VillagerEvent;
	import ageofai.villager.view.VillagerView;
=======
	import ageofai.map.constant.CMap;
>>>>>>> Stashed changes

	public class HomeView extends BaseBuildingView
	{
		public function HomeView()
		{
			this.createUI( HomeUI );
			this.createLifeBar();
			this.createProgressBar();

			this._graphicUI.x = CMap.TILE_SIZE;
			this._graphicUI.y = CMap.TILE_SIZE;
		}
		
		public function showProgressValue( value:Number):void
		{
			this._buildProgressBar.show();
			this._buildProgressBar.drawProcessBar( value );
		}
		
		public function createVillagerView():void
		{
            var homeViewEvent:HomeViewEvent = new HomeViewEvent( HomeViewEvent.VILLAGER_VIEW_CREATED );
            homeViewEvent.villagerView = new VillagerView( );
            this.dispatchEvent( homeViewEvent );
		}
	}
}
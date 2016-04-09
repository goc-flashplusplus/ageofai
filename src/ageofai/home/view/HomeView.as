/**
 * Created by newkrok on 08/04/16.
 */
package ageofai.home.view
{
	import ageofai.building.base.BaseBuildingView;
	import ageofai.home.view.event.HomeViewEvent;
	import ageofai.home.vo.HomeVO;
	import ageofai.map.geom.IntPoint;
	import ageofai.villager.view.VillagerView;

	import ageofai.map.constant.CMap;

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

		public function showProgressValue( value:Number ):void
		{
			this._buildProgressBar.show();
			this._buildProgressBar.drawProcessBar( value );
		}

		public function createVillagerView():void
		{
			var homeViewEvent:HomeViewEvent = new HomeViewEvent( HomeViewEvent.VILLAGER_VIEW_CREATED );

			var homeVO:HomeVO = new HomeVO();
			homeVO.wood = 0;
			homeVO.food = 0;
			homeVO.pos = new IntPoint( this.x / CMap.TILE_SIZE, this.y / CMap.TILE_SIZE );

			homeViewEvent.villagerView = new VillagerView();
			homeViewEvent.homeVO = homeVO;

			this.dispatchEvent( homeViewEvent );
		}
	}
}
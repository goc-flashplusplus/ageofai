/**
 * Created by newkrok on 08/04/16.
 */
package ageofai.building.view.home
{
	import ageofai.building.base.BaseBuildingView;

	public class HomeView extends BaseBuildingView
	{
		public function HomeView()
		{
			this.createUI( HomeUI );
			this.createLifeBar();
		}
	}
}
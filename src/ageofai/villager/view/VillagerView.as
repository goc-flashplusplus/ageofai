package ageofai.villager.view
{
	import ageofai.unit.base.BaseUnitView;
	import ageofai.unit.constant.CUnitProperties;
	import flash.display.MovieClip;

	/**
	 * ...
	 * @author Tibor Túri
	 */
	public class VillagerView extends BaseUnitView
	{

		public function VillagerView()
		{
			this.speed = CUnitProperties.VILLAGER_SPEED;
			this.createChildren();
		}

		override public function createChildren():void
		{
			this.createUI( VillagerUI );
			this.createLifeBar();
		}
		
		public function showHarvestAnimation():void
		{
			(this.graphicUI as MovieClip).gotoAndPlay("harvest");
		}
	}
}
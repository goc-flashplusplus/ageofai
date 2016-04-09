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
			(this.graphicUI as MovieClip).bag.visible = false;
			this.createLifeBar();
		}
		
		public function showHarvestAnimation():void
		{
			(this.graphicUI as MovieClip).bag.visible = true;
			(this.graphicUI as MovieClip).gotoAndPlay("harvest");
		}	
		
		public function showArriwedHomeAnimation():void
		{
			(this.graphicUI as MovieClip).bag.visible = false;
			(this.graphicUI as MovieClip).gotoAndPlay("move");
		}
	}
}
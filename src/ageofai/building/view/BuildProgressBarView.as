package ageofai.building.view 
{
	import ageofai.bar.BaseBarView;
	/**
	 * ...
	 * @author Tibor Túri
	 */
	public class BuildProgressBar extends BaseBarView
	{
		
		public function BuildProgressBar() 
		{
			this.barWidth = 20;
			this.barHeight = 5;
			this.backgroundColor = 0xFFFFFF;
			this.barColor = 0xFF0000;
			this.createChildren( );				
		}
		
	}

}
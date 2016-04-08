package ageofai.unit.view 
{
	import ageofai.bar.BaseBarView;
	/**
	 * ...
	 * @author Tibor Túri
	 */
	public class LifeBarView extends BaseBarView
	{
		
		public function LifeBarView() 
		{	
			this.barWidth = 20;
			this.barHeight = 5;
			this.backgroundColor = 0xFFFFFF;
			this.barColor = 0x00FF00;
			this.createChildren( );	
		}
		
	}

}
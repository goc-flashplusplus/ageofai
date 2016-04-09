/**
 * Created by vizoli on 4/9/16.
 */
package ageofai.home.vo
{
	import ageofai.map.geom.IntPoint;
	import ageofai.villager.vo.VillagerVO;

	public class HomeVO
	{
		public var id:int;
		public var food:int = 100;
		public var wood:int;
		public var villagers:Vector.<VillagerVO> = new Vector.<VillagerVO>();
		public var villagerIsCreating:Boolean;
		public var pos:IntPoint;
		public var objectFounds:Vector.<MapNodeVO> = new Vector.<MapNodeVO>();
	}
}
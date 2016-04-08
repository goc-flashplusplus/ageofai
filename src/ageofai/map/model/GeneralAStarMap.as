package ageofai.map.model {
	
	import ageofai.map.astar.AStar;
	import ageofai.map.astar.IAStarSearchable;
    import ageofai.map.model.MapNode;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GeneralAStarMap implements IAStarSearchable {
		private var height:int, width:int;
		private var tileMap:Vector.<Vector.<MapNode>>;
		
		public function GeneralAStarMap(tileMap:Vector.<Vector.<MapNode>>) {
			this.tileMap = tileMap;
			this.height = tileMap.length;
			this.width = (this.height > 0) ? tileMap[0].length : 0;
		}
		
		public function getTileMap():Vector.<Vector.<MapNode>> {
			return this.tileMap;
		}
		
		public function isWalkable(x:int, y:int):Boolean {
			if (x < 0 || x > width - 1 || y < 0 || y > height - 1) return false;
			
			return (this.tileMap[y][x].walkable);
		}
		
		public function getWidth():int {
			return this.width;
		}
		
		public function getHeight():int {
			return this.height;
		}
		
	}
	
}
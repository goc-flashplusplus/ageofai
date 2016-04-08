package ageofai.map.astar {
    import ageofai.map.geom.IntPoint;
	
	public class AStarNode extends IntPoint {
		
		public var g:Number = 0;
		public var h:Number = 0;
		public var cost:Number = 1;
		
		public var parent:AStarNode;
		
		public var walkable:Boolean;
		
		function AStarNode(x:int, y:int, walkable:Boolean=true) {
			super(x,y);
			this.walkable = walkable;
		}
		
		public function get f():Number {
			return g + h;
		}
	
	}
}
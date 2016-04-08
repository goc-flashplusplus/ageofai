package ageofai.map.astar {
	
    import ageofai.map.geom.IntPoint;
	import flash.utils.Dictionary;
	
	public class AStar {
		private var width:int;
		private var height:int;
		
		private var start:AStarNode;
		private var goal:AStarNode;
		
		private var map:Vector.<Vector.<AStarNode>>;
		
		public var open:Vector.<AStarNode>;
		
		public var closed:Vector.<AStarNode>;
		
		private var dist:Function = distEuclidian;
		//private var dist:Function = distManhattan;
	
		private static const COST_ORTHOGONAL:Number = 1;
		private static const COST_DIAGONAL:Number = 1.35;
		
		public static var cachedMaps:Dictionary;
		
		function AStar(map:IAStarSearchable, start:IntPoint, goal:IntPoint) {
			width = map.getWidth();
			height = map.getHeight();
			
			this.start = new AStarNode(start.x, start.y);
			this.goal = new AStarNode(goal.x, goal.y); 
			
			if (cachedMaps == null) {
				cachedMaps = new Dictionary(true);
			}
			
			this.map = cachedMaps[map];
			if (this.map == null) {
				this.map = createMap(map);
				cachedMaps[map] = this.map;
			} else {
				cleanMap(this.map);
			}
		}
		
		public function solve():Vector.<IntPoint> {
			var i:int, mneighbors:Vector.<AStarNode>, neighborCount:int;
			
			open = new Vector.<AStarNode>();
			closed = new Vector.<AStarNode>();
			
			
			var node:AStarNode = start;
			node.h = dist(goal);
			open[open.length] = node;
			
			var solved:Boolean = false;
			
			if (!goal.equals(start) && !map[goal.x - 1][goal.y].walkable && !map[goal.x - 1][goal.y - 1].walkable && 
					!map[goal.x][goal.y - 1].walkable && !map[goal.x + 1][goal.y - 1].walkable && 
					!map[goal.x + 1][goal.y].walkable && !map[goal.x + 1][goal.y + 1].walkable && 
					!map[goal.x][goal.y + 1].walkable && !map[goal.x - 1][goal.y + 1].walkable) {
				
				return null;
			}
			while (!solved) {
				open.sort(sortVector);
				if (open.length <= 0) break;
				node = open.shift();
				closed[closed.length] = node;
				
				if (node.x == goal.x && node.y == goal.y) {
					solved = true;
					break;
				}
				
				mneighbors = neighbors(node);
				neighborCount = mneighbors.length;
				for (i = 0; i < neighborCount; i++) {
					var n:AStarNode = mneighbors[i];
					
					if (open.indexOf(n) == -1 && closed.indexOf(n) == -1) {
						open[open.length] = n;
						n.parent = node;
						n.h = dist(n);
//						n.g = node.g;
					} else {
						var f:Number = n.g + node.g + n.h;
//						trace(n.x, n.y, n.g, n.h, node.g);
						if (f < n.f) {
							n.parent = node;
							n.g = node.g;
						}
					}
				}
				
				
			}

			if (solved) {
				i = 0;
				var solution:Vector.<IntPoint> = new Vector.<IntPoint>();
				solution[0] = new IntPoint(node.x, node.y);
				while (node.parent && node.parent != start) {
					node = node.parent;
					solution[++i] = new IntPoint(node.x, node.y);
				}
//				solution[++i] = new UIntPoint(node.x, node.y);
				solution[++i] = new IntPoint(start.x, start.y);;
				
				return solution;
			} else {
				return null;
			}
		}
		
		private function sortVector(x:AStarNode, y:AStarNode):int {
			return (x.f >= y.f) ? 1 : -1;
		}
		
		private function distManhattan(n1:AStarNode, n2:AStarNode=null):Number {
			if (n2 == null) n2 = goal;
			return Math.abs(n1.x-n2.x)+Math.abs(n1.y-n2.y);
		}
		
		private function distEuclidian(n1:AStarNode, n2:AStarNode=null):Number {
			if (n2 == null) n2 = goal;
			return Math.sqrt(Math.pow((n1.x - n2.x), 2) + Math.pow((n1.y - n2.y), 2));
		}
		
		
		private function neighbors(node:AStarNode):Vector.<AStarNode> {
			var x:int = node.x, y:int = node.y, i:int = -1;
			var n:AStarNode;
			var a:Vector.<AStarNode> = new Vector.<AStarNode>();
			
			
			// N
			if (x > 0) {
				n = map[x-1][y];
				if (n.walkable) {
					n.g += COST_ORTHOGONAL;
					a[++i] = n;
				}
			}

			// E
			if (x < width-1) {
				n = map[x+1][y];
				if (n.walkable) {
					n.g += COST_ORTHOGONAL;
					a[++i] = n;
				}
			} 

			// N
			if (y > 0) {
				n = map[x][y-1];
				if (n.walkable) {
					n.g += COST_ORTHOGONAL;
					a[++i] = n;
				}
			}

			// S
			if (y < height-1) {
				n = map[x][y+1];
				if (n.walkable) {
					n.g += COST_ORTHOGONAL;
					a[++i] = n;
				}
			}
			
			// NW
			if (x > 0 && y > 0) {
				n = map[x-1][y-1];
				if (n.walkable && map[x-1][y].walkable && map[x][y-1].walkable) {						
					n.g += COST_DIAGONAL;
					a[++i] = n;
				}
			}

			// NE
			if (x < width-1 && y > 0) {
				n = map[x+1][y-1];
				if (n.walkable && map[x+1][y].walkable && map[x][y-1].walkable) {
					n.g += COST_DIAGONAL;
					a[++i] = n;
				}
			}

			// SW
			if (x > 0 && y < height-1) {
				n = map[x-1][y+1];
				if (n.walkable && map[x-1][y].walkable && map[x][y+1].walkable) {
					n.g += COST_DIAGONAL;
					a[++i] = n;
				}
			}

			// SE
			if (x < width-1 && y < height-1) {
				n = map[x+1][y+1];
				if (n.walkable && map[x+1][y].walkable && map[x][y+1].walkable) {
					n.g += COST_DIAGONAL;
					a[++i] = n;
				}
			}
			
			return a;
			
		}
		
		private function cleanMap(map:Vector.<Vector.<AStarNode>>):void {
			for (var x:int = 0; x < width; x++) {
				for (var y:int = 0; y < height; y++) {
					var node:AStarNode = map[x][y];
					node.g = 0;
					node.h = 0;
					node.parent = null;
				}
			}
		}

		private function createMap(map:IAStarSearchable):Vector.<Vector.<AStarNode>> {
			var a:Vector.<Vector.<AStarNode>> = new Vector.<Vector.<AStarNode>>(width);

			for (var x:int = 0; x < width; x++) {
				a[x] = new Vector.<AStarNode>(height);
				for (var y:int = 0; y < height; y++) {
					var node:AStarNode = new AStarNode(x, y, map.isWalkable(x, y));
					a[x][y] = node;
				}
			}
			
			return a;
		}
	}
}
package ageofai.map.astar {
	
	public interface IAStarSearchable {
		function isWalkable(x:int, y:int):Boolean;
		function getWidth():int;
		function getHeight():int;
	}
}
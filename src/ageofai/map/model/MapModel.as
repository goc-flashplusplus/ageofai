/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.map.model
{
    import ageofai.map.model.GeneralAStarMap;
    import ageofai.map.astar.AStar;
    import ageofai.map.constant.CMapNodeType;
    import ageofai.map.event.MapCreatedEvent;
    import ageofai.map.geom.IntPoint;
    import common.mvc.model.base.BaseModel;

    public class MapModel extends BaseModel implements IMapModel
    {
        
        private var _astarMap:GeneralAStarMap;
        private var _map:Vector.<Vector.<MapNode>>;
        
        public function get map():Vector.<Vector.<MapNode>>
        {
            return this._map;
        }
        
        public function createMap(rowCount:int, columnCount:int ):void
        {
            this._map = new Vector.<Vector.<MapNode>>(rowCount, true);
            for (var i:int = 0; i < rowCount; i++)
            {
                _map[i] = new Vector.<MapNode>(columnCount, true);
                for (var j:int = 0; j < columnCount; j++ )
                {
                    _map[i][j] = getMapNode();
                }
            }
            
            // Get homes
            do
            {
                var homeA:IntPoint = getRandomPoint(0, columnCount, 0, rowCount * .25);
                var homeB:IntPoint = getRandomPoint(0, columnCount, rowCount * .5, rowCount * .25);
                
                // Make sure they are valid
                _astarMap = new GeneralAStarMap(_map);
                var a:AStar = new AStar(_astarMap, homeA, homeB);
                var solution:Vector.<IntPoint> = a.solve();
            } while (solution == null)
            
            
            this.eventDispatcher.dispatchEvent(new MapCreatedEvent(MapCreatedEvent.MAP_CREATED, this._map));
        }
        
        private function getMapNode():MapNode
        {
            var rnd:Number = Math.random() * 100;
            var type:int;
            
            if (rnd <= 50)
            {
                type = CMapNodeType.GRASS;
            }
            else if (rnd <= 85)
            {
                type = CMapNodeType.DARK_GRASS;
            }
            else
            {
                type = CMapNodeType.WATER;
            }
            
            return new MapNode(type);
        }
        
        private function getRandomPoint(offsetX:int, limitX:int, offsetY:int, limitY:int):IntPoint
        {
            var x:int = Math.random() * (limitX - offsetX) + offsetX;
            var y:int = Math.random() * (limitY - offsetY) + offsetY;
            
            return new IntPoint(x, y);
        }
    }
}

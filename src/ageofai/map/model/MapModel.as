/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.map.model
{
    import ageofai.map.constant.CMap;
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
        private var _homes:Vector.<IntPoint>;
        
        public function get map():Vector.<Vector.<MapNode>>
        {
            return this._map;
        }
        
        public function get homes():Vector.<IntPoint>
        {
            return this._homes;
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
            this._homes = new Vector.<IntPoint>(CMap.HOME_COUNT, true);
            var minDistanceX:int = columnCount / CMap.HOME_COUNT;
            var minDistanceY:int = rowCount / CMap.HOME_COUNT;
            var offsetX:int, offsetY:int;
            do
            {
                offsetX = offsetY = 0;
                for (i = 0; i < CMap.HOME_COUNT - 1; i++)
                {
                    this._homes[i] = getRandomPoint(offsetX, offsetX += minDistanceX, offsetY, offsetY += minDistanceY);
                }
                this._homes[i] = getRandomPoint(offsetX, columnCount, offsetY, rowCount);
                
                // Make sure they are valid
                _astarMap = new GeneralAStarMap(_map);
                for (i = 0; i < CMap.HOME_COUNT; i++)
                {
                    for (j = 0; j < CMap.HOME_COUNT; j++)
                    {
                        if (i == j) continue;
                        var aStar:AStar = new AStar(_astarMap, this._homes[i], this._homes[j]);
                        var solution:Vector.<IntPoint> = aStar.solve();
                        
                        if (solution) break;
                    }
                    if (!solution) break;
                }
            } while (!solution);
            
            this.eventDispatcher.dispatchEvent(new MapCreatedEvent(MapCreatedEvent.MAP_CREATED, this._map, this._homes));
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

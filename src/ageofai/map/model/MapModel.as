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
    import ageofai.map.vo.MapDataVO;
    import common.mvc.model.base.BaseModel;

    public class MapModel extends BaseModel implements IMapModel
    {
        
        private var _astarMap:GeneralAStarMap;
        private var _map:Vector.<Vector.<MapNode>>;
        private var _homes:Vector.<IntPoint>;
        private var _fruits:Vector.<IntPoint>;
        
        public function get map():Vector.<Vector.<MapNode>>
        {
            return this._map;
        }
        
        public function get homes():Vector.<IntPoint>
        {
            return this._homes;
        }
        
        public function get fruits():Vector.<IntPoint>
        {
            return this._fruits;
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
            
            // Fruits 
            this._fruits = new Vector.<IntPoint>();
            for (i = 0; i < CMap.HOME_COUNT; i++)
            {
                var nearFruitsNo:int = Math.round(Math.random() * 4) + 2;
                
                for (j = 0; j < nearFruitsNo; j++)
                {
                    do {
                        var fruitX:int = Math.round(Math.random() * 8) + (this._homes[i].x - 3);
                        var fruitY:int = Math.round(Math.random() * 8) + (this._homes[i].y - 3);
                    } while (fruitX < 0 || fruitX >= columnCount || fruitY < 0 || fruitY >= rowCount 
                        || (fruitX >= this._homes[i].x && fruitX <= this._homes[i].x + 2 && fruitY >= this._homes[i].y && fruitY <= this._homes[i].y + 2)
                        || !this._map[fruitY][fruitX].walkable)
                    
                    this._fruits[this._fruits.length] = new IntPoint(fruitX, fruitY);
                }
            }
            
            var farFruitsNo:int = Math.round(Math.random() * 2) + 8;
            for (i = 0; i < farFruitsNo; i++)
            {
                do {
                    var fruitPos:IntPoint = getRandomPoint(0, columnCount, 0, rowCount);
                } while (!this._map[fruitPos.y][fruitPos.x].walkable || distanceLessThan(8, fruitPos))
                
                this._fruits[this._fruits.length] = fruitPos;
            }
            
            this.eventDispatcher.dispatchEvent(new MapCreatedEvent(MapCreatedEvent.MAP_CREATED, this.getMapData()));
        }
        
        
        /* INTERFACE ageofai.map.model.IMapModel */
        
        public function getMapData():MapDataVO 
        {
            var mapData:MapDataVO = new MapDataVO();
            mapData.fruits = this._fruits;
            mapData.homes = this._homes;
            mapData.map = this._map;
            
            return mapData;
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
        
        private function distanceLessThan(units:int, pos:IntPoint):Boolean
        {
            for (var i:int = 0, count:int = this._homes.length; i < count; i++)
            {
                if (Math.abs(pos.x - this._homes[i].x) + Math.abs(pos.y - this._homes[i].y) < units)
                {
                    return true;
                }
            }
            return false;
        }
    }
}

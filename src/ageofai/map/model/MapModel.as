/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.map.model
{
    import ageofai.home.vo.HomeVO;
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
        private var _homes:Vector.<HomeVO>;
        private var _fruits:Vector.<IntPoint>;
        
        public function get map():Vector.<Vector.<MapNode>>
        {
            return this._map;
        }
        
        public function get homes():Vector.<HomeVO>
        {
            return this._homes;
        }
        
        public function get fruits():Vector.<IntPoint>
        {
            return this._fruits;
        }
        
        public function createMap(rowCount:int, columnCount:int ):void
        {
            //TODO: The easy way to go, when we create the objects change the map
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
            this._homes = getHomes(columnCount, rowCount);
            
            // Fruits 
            this._fruits = getFruits(columnCount, rowCount);
            
            this.eventDispatcher.dispatchEvent(new MapCreatedEvent(MapCreatedEvent.MAP_CREATED, this.getMapData()));
        }
        
        private function getHomes(columnCount:int, rowCount:int):Vector.<HomeVO>
        {
            var homes:Vector.<HomeVO> = new Vector.<HomeVO>(CMap.HOME_COUNT, true);
            var minDistanceX:int = columnCount / CMap.HOME_COUNT;
            var minDistanceY:int = rowCount / CMap.HOME_COUNT;
            var offsetX:int, offsetY:int;
            do
            {
                offsetX = offsetY = 0;
                for (var i:int = 0; i < CMap.HOME_COUNT - 1; i++)
                {
                    var home:HomeVO = new HomeVO();
                    home.pos = getRandomPoint(offsetX, offsetX += minDistanceX, offsetY, offsetY += minDistanceY);
                    homes[i] = home;
                }
                home = new HomeVO();
                home.pos = getRandomPoint(offsetX, columnCount, offsetY, rowCount);
                homes[i] = home;
                
                // Make sure they are valid
                _astarMap = new GeneralAStarMap(_map);
                for (i = 0; i < CMap.HOME_COUNT; i++)
                {
                    for (var j:int = 0; j < CMap.HOME_COUNT; j++)
                    {
                        if (i == j) continue;
                        var aStar:AStar = new AStar(_astarMap, homes[i].pos, homes[j].pos);
                        var solution:Vector.<IntPoint> = aStar.solve();
                        
                        if (solution) break;
                    }
                    if (!solution) break;
                }
            } while (!solution);
            
            return homes;
        }
        
        private function getFruits(columnCount:int, rowCount:int):Vector.<IntPoint>
        {
            var fruits:Vector.<IntPoint> = new Vector.<IntPoint>();
            for (var i:int = 0; i < CMap.HOME_COUNT; i++)
            {
                var nearFruitsNo:int = Math.round(Math.random() * 4) + 2;
                
                for (var j:int = 0; j < nearFruitsNo; j++)
                {
                    do {
                        var fruitX:int = Math.round(Math.random() * 8) + (this._homes[i].pos.x - 3);
                        var fruitY:int = Math.round(Math.random() * 8) + (this._homes[i].pos.y - 3);
                    } while (fruitX < 0 || fruitX >= columnCount || fruitY < 0 || fruitY >= rowCount 
                        || (fruitX >= this._homes[i].pos.x && fruitX <= this._homes[i].pos.x + 2 && fruitY >= this._homes[i].pos.y && fruitY <= this._homes[i].pos.y + 2)
                        || !this._map[fruitY][fruitX].walkable)
                    
                    fruits[fruits.length] = new IntPoint(fruitX, fruitY);
                }
            }
            
            var farFruitsNo:int = Math.round(Math.random() * 2) + 8;
            for (i = 0; i < farFruitsNo; i++)
            {
                do {
                    var fruitPos:IntPoint = getRandomPoint(0, columnCount, 0, rowCount);
                } while (!this._map[fruitPos.y][fruitPos.x].walkable || distanceLessThan(8, fruitPos))
                
                fruits[fruits.length] = fruitPos;
            }
            
            return fruits;
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
                if (Math.abs(pos.x - this._homes[i].pos.x) + Math.abs(pos.y - this._homes[i].pos.y) < units)
                {
                    return true;
                }
            }
            return false;
        }
    }
}

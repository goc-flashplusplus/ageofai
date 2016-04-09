package ageofai.unit.utils 
{
    import ageofai.home.vo.HomeVO;
    import ageofai.home.vo.MapNodeVO;
    import ageofai.map.constant.CMapNodeType;
    import ageofai.map.geom.IntPoint;
    import ageofai.map.model.IMapModel;
    import ageofai.map.model.MapNode;
    import ageofai.unit.base.IUnitView;
    import ageofai.unit.vo.DestinationDataVO;
    import ageofai.villager.constant.CVillagerStatus;
    import ageofai.villager.model.IVillagerModel;
    import ageofai.villager.vo.VillagerVO;
    import flash.geom.Point;
	/**
     * ...
     * @author 
     */
    public class VillagerAI implements IUnitAI
    {
        private var sightOffset:Array = [[ -2, -2 ], [ -2, -1 ], [ -2, 0 ], [ -2, 1 ], [ -2, 2 ],
            [ -1, -2 ], [ -1, -1 ], /*[ -1, 0 ],*/ [ -1, 1 ], [ -1, 2 ],
            [ 0, -2 ], /*[ 0, -1 ], [ 0, 1 ],*/ [ 0, 2 ],
            [ 1, -2 ], [ 1, -1 ], /*[ 1, 0 ],*/ [ 1, 1 ], [ 1, 2 ],
            [ 2, -2 ], [ 2, -1 ], [ 2, 0 ], [ 2, 1 ], [ 2, 2 ]];
        private var surroundings:Array = [[ -1, 0 ], [ 0, -1 ], [ 1, 0 ], [ 0, 1 ]];
            
        public function tick(villager:VillagerVO, mapModel:IMapModel, home:HomeVO):IntPoint
        {
            if ( villager.status == CVillagerStatus.IDLE && (villager.destination == null || villager.destination.currentEntry >= villager.destination.path.length - 1) )
            {
                var newPoint:IntPoint;
                
                var objectFounds:Vector.<MapNodeVO> = new Vector.<MapNodeVO>();
                // Ahead there be some code duplication we could avoid!
                // Check sight area
                for (var i:int = 0, count:int = sightOffset.length; i < count; i++)
                {
                    var newX:int = villager.position.x + sightOffset[i][0];
                    var newY:int = villager.position.y + sightOffset[i][1];
                    
                    if (newX < 0 || newY < 0 || newX >= mapModel.map[0].length || newY >= mapModel.map.length)
                    {
                        continue;
                    }
                    
                    newPoint = new IntPoint(newX, newY);
                    var objectType:int = mapModel.map[newY][newX].objectType;
                    if (objectType != CMapNodeType.OBJECT_NULL && objectType != CMapNodeType.OBJECT_HOME)
                    {
                        var nodeVO:MapNodeVO = new MapNodeVO();
                        nodeVO.pos = newPoint;
                        nodeVO.node = mapModel.map[newY][newX];
                        objectFounds[objectFounds.length] = nodeVO; 
					}
                }
                
                // Check surroundings
                var nextToObject:Boolean;
                for (i = 0, count = surroundings.length; i < count; i++)
                {
                    newX = villager.position.x + surroundings[i][0];
                    newY = villager.position.y + surroundings[i][1];
                    
                    if (newX < 0 || newY < 0 || newX >= mapModel.map[0].length || newY >= mapModel.map.length)
                    {
                        continue;
                    }
                    
                    newPoint = new IntPoint(newX, newY);
                    
                    objectType = mapModel.map[newY][newX].objectType;
                    if (objectType != CMapNodeType.OBJECT_NULL && objectType != CMapNodeType.OBJECT_HOME)
                    {
                        nextToObject = true;
                        nodeVO = new MapNodeVO();
                        nodeVO.pos = newPoint;
                        nodeVO.node = mapModel.map[newY][newX];
                        objectFounds[objectFounds.length] = nodeVO;
                    }
                }
                
                home.objectFounds = home.objectFounds.concat(objectFounds);
                
                if ( home.objectFounds.length == 0 || objectFoundsAlreadyTargetted(home) )
                {
                    // Move randomly
                    do {
                        var newPos:int = Math.round(Math.random() * 3);
                        newX = villager.position.x + surroundings[newPos][0];
                        newY = villager.position.y + surroundings[newPos][1];
                        
                        if (newX < 0 || newY < 0 || newX >= mapModel.map[0].length || newY >= mapModel.map.length)
                        {
                            continue;
                        }
                    
                        newPoint = new IntPoint(newX, newY);
                    } while (newPoint.x < 0 || newPoint.y < 0 || newPoint.x >= mapModel.map[0].length || newPoint.y >= mapModel.map.length ||
                        !mapModel.map[newPoint.y][newPoint.x].walkable);
                }
                else if (nextToObject)
                {
                    villager.destination = null;
                    villager.status = CVillagerStatus.HARVEST;
                    newPoint = null;
                }
                else
                {
                    // Go to object
                    i = 0;
                    do {
                        while (isOtherVillagerGoingTo(home, home.objectFounds[i].pos))
                        {
                            i++;
                        }
                        if (i >= home.objectFounds.length - 1) break;
                        var path:Vector.<IntPoint> = mapModel.getPath(villager.position, home.objectFounds[i].pos);
                        i++;
                    } while (path == null && i < home.objectFounds.length)
                    
                    if (path != null) 
                    {
                        newPoint = path[0];
                        villager.destination = new DestinationDataVO();
                        villager.destination.path = path;
                    }
                }
            }
            else
            {
                // Is current task still valid?
                if (villager.destination)
                {
                    var destPoint:IntPoint = villager.destination.path[0];
                    objectType = mapModel.map[destPoint.y][destPoint.x].objectType;
                    if (objectType == CMapNodeType.OBJECT_NULL || objectType == CMapNodeType.OBJECT_HOME)
                    {
                        villager.destination = null;
                    }
                    else
                    {
                        newPoint = villager.destination.path[villager.destination.currentEntry++];
                    }
                }
            }
            
            return newPoint;
        }
        
        private function objectFoundsAlreadyTargetted(home:HomeVO):Boolean
        {
            for each (var objectFound:MapNodeVO in home.objectFounds)
            {
                if (!isOtherVillagerGoingTo(home, objectFound.pos)) return false;
            }
            return true;
        }
        
        private function isOtherVillagerGoingTo(home:HomeVO, pos:IntPoint):Boolean
        {
            for each (var villager:VillagerVO in home.villagers)
            {
                if (villager.destination == null) continue;
                
                if (villager.destination.path[villager.destination.path.length - 1] == pos)
                {
                    return true;
                }
            }
            return false;
        }
    }

}
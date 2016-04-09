package ageofai.unit.utils 
{
    import ageofai.home.vo.HomeVO;
    import ageofai.home.vo.MapNodeVO;
    import ageofai.map.constant.CMapNodeType;
    import ageofai.map.geom.IntPoint;
    import ageofai.map.model.IMapModel;
    import ageofai.map.model.MapNode;
    import ageofai.unit.base.IUnitView;
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
        private var surroundings:Array = [[ -1, 0 ], [ 0, -1 ], [ 1, 0 ], [ 0, 1 ]];
            
        public function tick(villager:VillagerVO, mapModel:IMapModel, home:HomeVO):IntPoint
        {
            if ( villager.status == CVillagerStatus.IDLE )
            {
                var newPoint:IntPoint;
                
                // Check surrounding
                var objectFounds:Vector.<MapNodeVO> = new Vector.<MapNodeVO>();
                for (var i:int = 0, count:int = surroundings.length; i < count; i++)
                {
                    var newX:int = villager.position.x + surroundings[i][0];
                    var newY:int = villager.position.y + surroundings[i][1];
                    
                    if (newX < 0 || newY < 0 || newX > mapModel.map[0].length || newY > mapModel.map.length)
                    {
                        continue;
                    }
                    
                    newPoint = new IntPoint(newX, newY);
                    
                    if (mapModel.map[newY][newX].objectType != CMapNodeType.OBJECT_NULL)
                    {
                        var nodeVO:MapNodeVO = new MapNodeVO();
                        nodeVO.pos = newPoint;
                        nodeVO.node = mapModel.map[newY][newX];
                        objectFounds[objectFounds.length] = nodeVO;
                    }
                }
                
                home.objectFounds = home.objectFounds.concat(objectFounds);
                
                if ( home.objectFounds.length == 0 )
                {
                    // Move randomly
                    do {
                        var newPos:int = Math.round(Math.random() * 4);
                        newX = villager.position.x + surroundings[newPos][0];
                        newY = villager.position.y + surroundings[newPos][1];
                        
                        if (newX < 0 || newY < 0 || newX > mapModel.map[0].length || newY > mapModel.map.length)
                        {
                            continue;
                        }
                    
                        newPoint = new IntPoint(newX, newY);
                    } while (newPoint.x < 0 || newPoint.y < 0 || newPoint.x >= mapModel.map[0].length || newPoint.y >= mapModel.map.length ||
                        !mapModel.map[newPoint.y][newPoint.x].walkable);
                }
                else
                {
                    // Go to object 
                    //mapModel.getPath(, )
                }
            }
            else
            {
                // Is current task still valid?
            }
            
            return newPoint;
        }
    }

}
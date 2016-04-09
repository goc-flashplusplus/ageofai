package ageofai.unit.utils 
{
    import ageofai.home.vo.HomeVO;
    import ageofai.map.model.IMapModel;
    import ageofai.villager.vo.VillagerVO;
	/**
     * ...
     * @author 
     */
    public interface IUnitAI 
    {
        
        function tick(villager:VillagerVO, mapModel:IMapModel, home:HomeVO):void;
        
    }
    
}
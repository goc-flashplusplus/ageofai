/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.villager.model
{
<<<<<<< HEAD
    import ageofai.map.geom.IntPoint;
    import ageofai.villager.vo.VillagerVO;
=======
	import ageofai.home.vo.HomeVO;
	import ageofai.unit.base.IUnitView;
>>>>>>> origin/master

	public interface IVillagerModel
	{

<<<<<<< HEAD
        function tick():void;

        function getVillagers():Vector.<VillagerVO>;

        function addVillager( villagerVO:VillagerVO, pos:IntPoint ):void;

    }
=======
		function getVillagers():Vector.<IUnitView>;

		function addVillager( unit:IUnitView, homeVO:HomeVO ):void;
	}
>>>>>>> origin/master
}
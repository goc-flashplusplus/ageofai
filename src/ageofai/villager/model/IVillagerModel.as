/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.villager.model
{
	import ageofai.home.vo.HomeVO;
	import ageofai.unit.base.IUnitView;

	public interface IVillagerModel
	{

		function getVillagers():Vector.<IUnitView>;

		function addVillager( unit:IUnitView, homeVO:HomeVO ):void;
	}
}
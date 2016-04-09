/**
 * Created by newkrok on 09/04/16.
 */
package ageofai.fruit.model
{
	import ageofai.fruit.vo.FruitVO;

	public interface IFruitModel
	{
		function getFruitAmountById( id:int ):int;

		function addFruit( fruitVO:FruitVO ):void;
	}
}
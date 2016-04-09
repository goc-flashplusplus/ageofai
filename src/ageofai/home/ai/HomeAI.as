/**
 * Created by vizoli on 4/9/16.
 */
package ageofai.home.ai
{
    import ageofai.cost.constant.CUnitCost;

    public class HomeAI
    {
        public function HomeAI()
        {
        }

        public function isNewVillagerAvailable( foodAmount:int, villagerAmount:int ):Boolean
        {
            var result:Boolean;

            if ( foodAmount > CUnitCost.VILLAGER.food )
            {
                result = true;
            }

            return result;
        }
    }
}

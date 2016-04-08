package ageofai.config
{
import ageofai.unit.view.villager.VillagerMediator;
import ageofai.unit.view.villager.VillagerView;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.framework.api.IConfig;

/**
	 * Mediators config.
	 * 
	 * @author vizoli
	 */
	public class MediatorConfig implements IConfig
	{
		[Inject]
		public var mediatorMap:IMediatorMap;
		
		/**
		 * Configure.
		 */
		public function configure():void
		{
			//this.mediatorMap.map( FieldView ).toMediator( FieldMediator );
			this.mediatorMap.map( VillagerView ).toMediator( VillagerMediator );
		}
		
	}

}
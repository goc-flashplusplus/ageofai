package ageofai.config
{
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
		}
		
	}

}
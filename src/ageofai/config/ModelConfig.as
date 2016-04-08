package ageofai.config
{
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IInjector;


	public class ModelConfig implements IConfig
	{
		[Inject]
		public var injector:IInjector;
		
		/**
		 * Configure.
		 */
		public function configure():void
		{
			//this.injector.map( IFieldModel ).toSingleton( FieldModel );
		}
		
	}

}
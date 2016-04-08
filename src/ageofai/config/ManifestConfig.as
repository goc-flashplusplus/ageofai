package ageofai.config
{
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IInjector;

/**
	 * Manifest config.
	 * 
	 * @author vizoli
	 */
	public class ManifestConfig implements IConfig 
	{
		[Inject]
		public var injector:IInjector;
		
		/**
		 * Configure.
		 */
		public function configure():void 
		{
			//this.injector.map( IManifest, "diamond" ).toSingleton( DiamondManifest );
		}
		
	}

}
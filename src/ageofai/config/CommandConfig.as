package ageofai.config
{
import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
import robotlegs.bender.framework.api.IConfig;

/**
	 * CommandConfig.
	 * 
	 * @author vizoli
	 */
	public class CommandConfig implements IConfig 
	{
		[Inject]
		public var commandMap:IEventCommandMap;
		
		/**
		 * Configure.
		 */
		public function configure():void
		{
			//this.commandMap.map( FieldViewEvent.CREATE_FIELD, FieldViewEvent ).toCommand( CreateFieldCommand );
		}
		
	}

}
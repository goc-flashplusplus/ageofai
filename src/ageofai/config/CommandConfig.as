package ageofai.config
{
	import ageofai.game.controller.CreateMapCommand;
	import ageofai.game.controller.InitGameCommand;
	import ageofai.game.controller.ProcessTickCommand;
	import ageofai.game.event.GameEvent;
	import ageofai.home.controller.SetInitHomesCommand;
	import ageofai.home.event.HomeEvent;
	import ageofai.map.event.MapCreatedEvent;
	import ageofai.villager.controller.AddVillagerViewCommand;
	import ageofai.villager.controller.StartRandomVillagerMovementCommand;
	import ageofai.villager.event.VillagerEvent;

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
			//GameEvent
			this.commandMap.map( GameEvent.INIT_GAME ).toCommand( InitGameCommand );
			this.commandMap.map( GameEvent.INIT_GAME ).toCommand( CreateMapCommand );
			this.commandMap.map( GameEvent.TICK ).toCommand( ProcessTickCommand );

			//MapCreatedEvent
			this.commandMap.map( MapCreatedEvent.MAP_CREATED ).toCommand( SetInitHomesCommand );

			//HomeEvent
			this.commandMap.map( HomeEvent.VILLAGER_VIEW_CREATED ).toCommand( AddVillagerViewCommand );

			//VillagerEvent
			this.commandMap.map( VillagerEvent.REQUEST_TO_MOVE_RANDOM ).toCommand( StartRandomVillagerMovementCommand );
		}

	}

}
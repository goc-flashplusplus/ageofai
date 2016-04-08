package ageofai.config
{
    import ageofai.game.controller.CreateMapCommand;
    import ageofai.game.controller.InitGameCommand;
    import ageofai.game.controller.ProcessTickCommand;
    import ageofai.game.event.GameEvent;

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
            this.commandMap.map( GameEvent.INIT_GAME ).toCommand( InitGameCommand );
            this.commandMap.map( GameEvent.INIT_GAME ).toCommand( CreateMapCommand );
            this.commandMap.map( GameEvent.TICK ).toCommand( ProcessTickCommand );
        }

    }

}
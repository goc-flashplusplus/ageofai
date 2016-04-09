package ageofai.villager.event 
{
    import ageofai.home.vo.HomeVO;
    import ageofai.unit.base.IUnitView;
    import ageofai.villager.view.VillagerView;
    import ageofai.villager.vo.VillagerVO;

    import flash.events.Event;
	/**
	 * ...
	 * @author Tibor Túri
	 */
	public class VillagerEvent extends Event
	{
        public static const VILLAGER_CREATED:String = "VillagerEvent.created";
        public static const VILLAGER_DIED:String = "VillagerEvent.died";
        public static const VILLAGER_MOVE:String = "VillagerEvent.move";
        public static const VILLAGER_HARVEST:String = "VillagerEvent.harvest";
        public static const VILLAGER_ARRIWED_HOME:String = "VillagerEvent.arriwedHome";
		
        public var progressPercentage:int;
        public var homeVO:HomeVO;
        public var villager:VillagerVO;

        public function VillagerEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false )
        {
            super( type, bubbles, cancelable );
        }

        public override function clone():Event
        {
            var event:VillagerEvent = new VillagerEvent( type );

            return event;
        }		
	}

}
/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.home.event
{
	import ageofai.villager.view.VillagerView;
    import flash.events.Event;

    public class HomeEvent extends Event
    {
        public static const VILLAGER_CREATION_IN_PROGRESS:String = "HomeEvent.villagerCreationInProgress";
        public static const VILLAGER_CREATED:String = "HomeEvent.villagerCreated";
        public static const VILLAGER_VIEW_CREATED:String = "HomeEvent.villagerViewCreated";

        public var progressPercentage:int;
        public var villagerView:VillagerView

        public function HomeEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false )
        {
            super( type, bubbles, cancelable );
        }

        public override function clone():Event
        {
            var event:HomeEvent = new HomeEvent( type );
            event.progressPercentage = progressPercentage;

            return event;
        }
    }
}

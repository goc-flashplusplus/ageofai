/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.home.view.event
{
    import ageofai.home.vo.HomeVO;
    import ageofai.villager.view.VillagerView;
    import flash.events.Event;

    public class HomeViewEvent extends Event
    {
        public static const VILLAGER_VIEW_CREATED:String = "HomeViewEvent.villagerViewCreated";

        public var villagerView:VillagerView;
        public var homeVO:HomeVO;

        public function HomeViewEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false )
        {
            super( type, bubbles, cancelable );
        }

        public override function clone():Event
        {
            var event:HomeViewEvent = new HomeViewEvent( type );
            event.villagerView = this.villagerView;
            event.homeVO = this.homeVO;

            return event;
        }
    }
}

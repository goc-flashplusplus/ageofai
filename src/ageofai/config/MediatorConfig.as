package ageofai.config
{
<<<<<<< HEAD
	import ageofai.layout.view.LayoutMediator;
	import ageofai.layout.view.LayoutView;
=======
	import ageofai.building.view.home.HomeMediator;
	import ageofai.building.view.home.HomeView;
>>>>>>> origin/master
	import ageofai.map.view.MapMediator;
	import ageofai.map.view.MapView;
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
			this.mediatorMap.map( LayoutView ).toMediator( LayoutMediator );
			this.mediatorMap.map( MapView ).toMediator( MapMediator );
			this.mediatorMap.map( VillagerView ).toMediator( VillagerMediator );
			this.mediatorMap.map( HomeView ).toMediator( HomeMediator );
		}
	}
}
package ageofai.config
{
	import ageofai.fruit.view.FruitMediator;
	import ageofai.fruit.view.FruitView;
	import ageofai.layout.view.view.LayoutMediator;
	import ageofai.layout.view.view.LayoutView;
	import ageofai.home.view.HomeMediator;
	import ageofai.home.view.HomeView;
	import ageofai.map.view.MapMediator;
	import ageofai.map.view.MapView;
	import ageofai.scout.view.ScoutMediator;
	import ageofai.scout.view.ScoutView;
	import ageofai.villager.view.VillagerMediator;
	import ageofai.villager.view.VillagerView;

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
			this.mediatorMap.map( FruitView ).toMediator( FruitMediator );
			this.mediatorMap.map( VillagerView ).toMediator( VillagerMediator );
			this.mediatorMap.map( ScoutView ).toMediator( ScoutMediator );
			this.mediatorMap.map( HomeView ).toMediator( HomeMediator );
		}
	}
}
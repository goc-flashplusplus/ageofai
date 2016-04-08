package
{
	import ageofai.bars.BaseBarView;
    import ageofai.config.CommandConfig;
    import ageofai.config.ManifestConfig;
    import ageofai.config.MediatorConfig;
    import ageofai.config.ModelConfig;
    import ageofai.layout.view.LayoutView;
	import ageofai.map.constant.CMap;
	import ageofai.unit.view.villager.VillagerView;
	import flash.geom.Point;

    import common.mvc.view.base.ABaseView;

    import flash.display.StageAlign;

    import flash.display.StageScaleMode;

    import flash.events.Event;

    import robotlegs.bender.bundles.mvcs.MVCSBundle;
    import robotlegs.bender.extensions.contextView.ContextView;
    import robotlegs.bender.framework.api.IContext;
    import robotlegs.bender.framework.impl.Context;

    [SWF(width="800", height="600", frameRate="60")]
    public class AgeOfAI extends ABaseView
    {
        private var _context:IContext;
        private var _layoutView:LayoutView;

        public function AgeOfAI()
        {
            if (this.stage)
            {
                this.init();
            }
            else
            {
                this.addEventListener(Event.ADDED_TO_STAGE, this.init);
            }
        }

        /**
         * Create the children.
         */
        override public function createChildren():void
        {
            this.createLayout();
			
			var villager:VillagerView = new VillagerView();
			this.addChild( villager );
			villager.createChildren();
			
			villager.moveTo( new Point( CMap.TILE_SIZE * 5, 0));
			
			var villager2:VillagerView = new VillagerView();
			this.addChild( villager2 );
			villager2.createChildren();
			
			villager2.moveTo( new Point( 0,CMap.TILE_SIZE * 1));			
        }

        /**
         * Create the layout.
         */
        private function createLayout():void
        {
            this._layoutView = new LayoutView();
            this._layoutView.createChildren();

            this.addChild(this._layoutView);
        }

        /**
         * Setup the context.
         */
        private function setupContext():void
        {
            this._context = new Context().install(MVCSBundle)
                    .configure(ModelConfig,
                    ManifestConfig,
                    MediatorConfig,
                    CommandConfig,
                    new ContextView(this)
            );
        }

        private function init(e:Event = null):void
        {
            this.removeEventListener(Event.ADDED_TO_STAGE, this.init);

            this.stage.scaleMode = StageScaleMode.NO_SCALE;
            this.stage.align = StageAlign.TOP_LEFT;

            this.setupContext();
            this.createChildren();
        }
    }
}

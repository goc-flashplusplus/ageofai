package
{
    import ageofai.config.CommandConfig;
    import ageofai.config.ManifestConfig;
    import ageofai.config.MediatorConfig;
    import ageofai.config.ModelConfig;
    import ageofai.game.event.GameEvent;
    import ageofai.layout.view.LayoutView;

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
            this._context = new Context().install( MVCSBundle )
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

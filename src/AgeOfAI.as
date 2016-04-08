package
{

import ageofai.config.CommandConfig;
import ageofai.config.ManifestConfig;
import ageofai.config.MediatorConfig;
import ageofai.config.ModelConfig;

import common.mvc.view.base.ABaseView;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.text.TextField;

import robotlegs.bender.bundles.mvcs.MVCSBundle;
import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.impl.Context;

public class AgeOfAI extends ABaseView
{
    private var _context:IContext;
    private var _layoutView:Sprite;

    public function AgeOfAI()
    {
        if (this.stage) this.init();
        else this.addEventListener(Event.ADDED_TO_STAGE, this.init);
        var textField:TextField = new TextField();
        textField.text = "Hello, World";
        addChild(textField);
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
        this._layoutView = new Sprite();
        //this._layoutView.createChildren();

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

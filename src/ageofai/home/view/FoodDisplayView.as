/**
 * Created by vizoli on 4/9/16.
 */
package ageofai.home.view
{
    import common.mvc.view.base.ABaseView;

    import flash.display.MovieClip;
    import flash.text.TextField;

    public class FoodDisplayView extends ABaseView
    {
        private var _iconView:MovieClip;
        private var _amountText:TextField;
        private var _amount:int = 0;

        public function FoodDisplayView()
        {
            this.createChildren();

            this.updateAmount( this._amount );
        }

        override public function createChildren():void
        {
            this._iconView = new FoodDisplayIconUI();
            this.addChild( this._iconView );

            this._amountText = new TextField();
            this.addChild( this._amountText );
        }

        public function updateAmount( amount:int ):void
        {
            this._amount = amount;

            this._amountText.text = String( this._amount );
        }
    }
}

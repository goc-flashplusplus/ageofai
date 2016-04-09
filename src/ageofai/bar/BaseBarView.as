package ageofai.bar 
{
	import common.mvc.view.base.ABaseView;
	import flash.display.Shape;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Tibor Túri
	 */
	public class BaseBarView extends ABaseView
	{
		private var _background:Sprite;
		private var _processBar:Sprite;
		
		private var _backgroundColor:Number;
		private var _barColor:Number;
		
		private var _barWidth:Number = 20;
		private var _barHeight:Number = 5;
		
		public function BaseBarView() 
		{
			this._background = new Sprite();
			this.addChild( this._background );
			
			this._processBar = new Sprite();
			this.addChild( this._processBar );
		}
		
		override public function createChildren():void
		{
			this.drawBackground();
		}
		
		public function drawProcessBar( percent:Number ):void
		{
			if ( percent == 1 || percent == 0 )
			{
				this.visible = false;
				return;
			}
			else if ( !this.visible )
			{
				this.visible = true;
			}

			if (this._processBar.numChildren > 0)
			{
				this._processBar.removeChildAt(0);			
			}
			
			var targetWidth:Number = this._barWidth * percent;
			
			var rectangle:Shape = new Shape; 
			rectangle.graphics.beginFill( this._barColor );
			rectangle.graphics.drawRect(0, 0, targetWidth, this._barHeight);
			rectangle.graphics.endFill();
			this._processBar.addChild( rectangle );
		}
		
		private function drawBackground():void
		{
			var rectangle:Shape = new Shape; 
			rectangle.graphics.beginFill( this._backgroundColor );
			rectangle.graphics.drawRect(0, 0,this._barWidth, this._barHeight);
			rectangle.graphics.endFill();
			this._background.addChild( rectangle );			
		}
		
		public function set backgroundColor(value:Number):void 
		{
			this._backgroundColor = value;
		}
		
		public function set barColor(value:Number):void 
		{
			this._barColor = value;
		}
		
		public function set barWidth(value:Number):void 
		{
			this._barWidth = value;
		}
		
		public function set barHeight(value:Number):void 
		{
			this._barHeight = value;
		}
		
		public function get barWidth():Number 
		{
			return _barWidth;
		}
		
		public function hide():void
		{
			this.visible = false;
		}
		
		public function show():void
		{
			this.visible = true;
		}
	}

}
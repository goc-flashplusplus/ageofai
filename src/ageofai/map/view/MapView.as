/**
 * Created by newkrok on 08/04/16.
 */
package ageofai.map.view
{
	import ageofai.map.model.MapNode;

	import common.mvc.view.base.ABaseView;

	import flash.display.Bitmap;
	import flash.display.BitmapData;

	public class MapView extends ABaseView
	{
		private var _baseBackground:Bitmap;

		public function MapView()
		{
		}

		private function createMap( mapMatrix:Vector.<Vector.<MapNode>> ):void
		{
			var lineCount:int = mapMatrix.length;
			var colCount:int = mapMatrix[0].length;

			var backgroundBitmapData:BitmapData = new BitmapData( lineCount * 32, colCount * 32, false, 0 );
			backgroundBitmapData.lock();

			for ( var i:int; i < colCount; i++ )
			{
				for( var j:int; j < lineCount; j++ )
				{
					this.drawTerrainToBitmapData( i, j, backgroundBitmapData );
				}
			}

			backgroundBitmapData.unlock();
			this._baseBackground = new Bitmap( backgroundBitmapData );
			addChild( this._baseBackground );
		}

		private function drawTerrainToBitmapData( col:uint, row:uint, backgroundBitmapData:BitmapData ):void
		{
			//backgroundBitmapData.draw(  );
		}
	}
}
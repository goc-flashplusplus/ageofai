/**
 * Created by newkrok on 08/04/16.
 */
package ageofai.map.view
{
	import ageofai.map.model.MapNode;

	import common.mvc.view.base.ABaseView;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;

	public class MapView extends ABaseView
	{
		private var _baseBackground:Bitmap;

		private var _terrainHelper:TerrainHelper;

		public function MapView()
		{
			var testMap:Vector.<Vector.<MapNode>> = new <Vector.<MapNode>>[];

			for ( var i:int = 0; i < 800 / 32; i++ )
			{
				testMap.push( new <MapNode>[] );

				for ( var j:int = 0; j < 600 / 32; j++ )
				{
					testMap[i].push( new MapNode() );
				}
			}

			this.createMap( testMap );
		}

		private function createMap( mapMatrix:Vector.<Vector.<MapNode>> ):void
		{
			this._terrainHelper = new TerrainHelper();
			this._terrainHelper.createBaseTerrainBitmapDatas();

			var lineCount:int = mapMatrix.length;
			var colCount:int = mapMatrix[0].length;

			var backgroundBitmapData:BitmapData = new BitmapData( lineCount * 32, colCount * 32, false, 0 );
			backgroundBitmapData.lock();

			for ( var i:int = 0; i < lineCount; i++ )
			{
				for( var j:int = 0; j < colCount; j++ )
				{
					this.drawTerrainToBitmapData( i, j, backgroundBitmapData );
				}
			}

			backgroundBitmapData.unlock();
			this._baseBackground = new Bitmap( backgroundBitmapData );
			addChild( this._baseBackground );

			this._terrainHelper.dispose();
		}

		private function drawTerrainToBitmapData( col:uint, row:uint, backgroundBitmapData:BitmapData ):void
		{
			var positionMatrix:Matrix = new Matrix();
			positionMatrix.tx = col * 32;
			positionMatrix.ty = row * 32;

			backgroundBitmapData.draw( Math.random() > .5 ? this._terrainHelper.terrainGrassUI : this._terrainHelper.terrainDarkGrassUI, positionMatrix );
		}
	}
}
/**
 * Created by newkrok on 08/04/16.
 */
package ageofai.map.view
{
	import ageofai.forest.view.ForestView;
	import ageofai.home.view.HomeView;
	import ageofai.map.constant.CMap;
    import ageofai.map.constant.CMapNodeType;
    import ageofai.map.geom.IntPoint;
	import ageofai.map.model.MapNode;

	import common.mvc.view.base.ABaseView;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;

	public class MapView extends ABaseView
	{
		private var _staticLayer:Sprite;
		private var _dynamicsLayer:Sprite;

		private var _terrainHelper:TerrainHelper;

		public function MapView()
		{
			this.createLayers();
		}

		private function createLayers():void
		{
			this._staticLayer = new Sprite();
			this.addChild( this._staticLayer );

			this._dynamicsLayer = new Sprite();
			this.addChild( this._dynamicsLayer );
		}

		public function createMap(mapMatrix:Vector.<Vector.<MapNode>>, homes:Vector.<IntPoint>):void
		{
			this._terrainHelper = new TerrainHelper();
			this._terrainHelper.createBaseTerrainBitmapDatas();

			var lineCount:int = mapMatrix.length;
			var colCount:int = mapMatrix[ 0 ].length;

			var backgroundBitmapData:BitmapData = new BitmapData( lineCount * 32, colCount * 32, false, 0 );
			backgroundBitmapData.lock();

			for( var i:int = 0; i < lineCount; i++ )
			{
				for( var j:int = 0; j < colCount; j++ )
				{
					this.drawTerrainToBitmapData( i, j, backgroundBitmapData, mapMatrix[i][j].type );
				}
			}

			backgroundBitmapData.unlock();

			this._staticLayer.addChild( new Bitmap( backgroundBitmapData ) );
            
            for each (var home:IntPoint in homes)
            {
                this.createHome(home);
            }

			this._terrainHelper.dispose();
		}

		public function addForest( x:int, y:int ):void
		{
			var forest:ForestView = new ForestView();
			this._dynamicsLayer.addChild( new ForestView() );
		}

		private function drawTerrainToBitmapData( col:uint, row:uint, backgroundBitmapData:BitmapData, type:int ):void
		{
			var positionMatrix:Matrix = new Matrix();
			positionMatrix.tx = col * CMap.TILE_SIZE;
			positionMatrix.ty = row * CMap.TILE_SIZE;

			backgroundBitmapData.draw( type == CMapNodeType.GRASS ? this._terrainHelper.terrainGrassUI : this._terrainHelper.terrainDarkGrassUI, positionMatrix );
		}
        
		private function createHome(pos:IntPoint):void
		{
			var home:HomeView = this._dynamicsLayer.addChild( new HomeView() ) as HomeView;
			home.x = CMap.TILE_SIZE * pos.x;
			home.y = CMap.TILE_SIZE * pos.y;
		}
	}
}
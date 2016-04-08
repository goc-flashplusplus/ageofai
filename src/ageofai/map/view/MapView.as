/**
 * Created by newkrok on 08/04/16.
 */
package ageofai.map.view
{
	import ageofai.building.view.home.HomeView;
	import ageofai.building.view.home.HomeView;
	import ageofai.map.constant.CMap;
	import ageofai.map.model.MapNode;

	import common.mvc.view.base.ABaseView;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;

	public class MapView extends ABaseView
	{
		private var _terrainLayer:Sprite;
		private var _unitLayer:Sprite;

		private var _terrainHelper:TerrainHelper;

		public function MapView()
		{
			var testMap:Vector.<Vector.<MapNode>> = new <Vector.<MapNode>>[];

			for ( var i:int = 0; i < CMap.ROW_COUNT; i++ )
			{
				testMap.push( new <MapNode>[] );

				for ( var j:int = 0; j < CMap.COLUMN_COUNT; j++ )
				{
					testMap[i].push( new MapNode() );
				}
			}

			this.createLayers();

			this.createMap( testMap );

			this.createHome();
			this.createHome();
			this.createHome();
			this.createHome();

			this.addEventListener( Event.ENTER_FRAME, this.onEnterFrameHandler );
		}

		private function createHome():void
		{
			var home:HomeView = this.addChild( new HomeView() ) as HomeView;
			home.x = CMap.TILE_SIZE * Math.floor( Math.random() * CMap.COLUMN_COUNT );
			home.y = CMap.TILE_SIZE * Math.floor( Math.random() * CMap.ROW_COUNT );
		}

		private function createLayers():void
		{
			this._terrainLayer = new Sprite();
			this.addChild( this._terrainLayer );

			this._unitLayer = new Sprite();
			this.addChild( this._unitLayer );
		}

		private function createMap( mapMatrix:Vector.<Vector.<MapNode>> ):void
		{
			this._terrainHelper = new TerrainHelper();
			this._terrainHelper.createBaseTerrainBitmapDatas();

			var lineCount:int = mapMatrix.length;
			var colCount:int = mapMatrix[0].length;

			var backgroundBitmapData:BitmapData = new BitmapData( lineCount * CMap.TILE_SIZE, colCount * CMap.TILE_SIZE, false, 0 );
			backgroundBitmapData.lock();

			for ( var i:int = 0; i < lineCount; i++ )
			{
				for( var j:int = 0; j < colCount; j++ )
				{
					this.drawTerrainToBitmapData( i, j, backgroundBitmapData );
				}
			}

			backgroundBitmapData.unlock();
			this._terrainLayer.addChild( new Bitmap( backgroundBitmapData ) );

			this._terrainHelper.dispose();
		}

		private function drawTerrainToBitmapData( col:uint, row:uint, backgroundBitmapData:BitmapData ):void
		{
			var positionMatrix:Matrix = new Matrix();
			positionMatrix.tx = col * CMap.TILE_SIZE;
			positionMatrix.ty = row * CMap.TILE_SIZE;

			backgroundBitmapData.draw( Math.random() > .5 ? this._terrainHelper.terrainGrassUI : this._terrainHelper.terrainDarkGrassUI, positionMatrix );
		}

		private function onEnterFrameHandler( event:Event ):void
		{
			this.zOrder();
		}

		private function zOrder():void
		{

		}
	}
}
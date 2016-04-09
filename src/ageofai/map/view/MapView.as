/**
 * Created by newkrok on 08/04/16.
 */
package ageofai.map.view
{
	import ageofai.forest.view.ForestView;
	import ageofai.fruit.view.FruitView;
	import ageofai.home.view.HomeView;
    import ageofai.home.vo.HomeVO;
	import ageofai.map.constant.CMap;
	import ageofai.map.constant.CMapNodeType;
	import ageofai.map.geom.IntPoint;
	import ageofai.map.model.MapNode;
    import ageofai.map.vo.MapDataVO;
	import ageofai.villager.vo.VillagerVO;

	import common.mvc.view.base.ABaseView;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.utils.Dictionary;

	public class MapView extends ABaseView
	{
		private var _staticLayer:Sprite;
		private var _dynamicsLayer:Sprite;

		private var _terrainHelper:TerrainHelper;

		private var _terrainManifest:Dictionary;

		public function MapView()
		{
			this._terrainHelper = new TerrainHelper();
			this._terrainHelper.createBaseTerrainBitmapDatas();

			this.createTerrainManifest();
			this.createLayers();

			this.addEventListener( Event.ENTER_FRAME, this.onEnterFrameHandler );
		}

		private function createTerrainManifest():void
		{
			this._terrainManifest = new Dictionary();

			this._terrainManifest[CMapNodeType.GRASS] = this._terrainHelper.terrainGrassUI;
			this._terrainManifest[CMapNodeType.DARK_GRASS] = this._terrainHelper.terrainDarkGrassUI;
			this._terrainManifest[CMapNodeType.WATER] = this._terrainHelper.terrainWaterUI;
		}

		private function createLayers():void
		{
			this._staticLayer = new Sprite();
			this.addChild( this._staticLayer );

			this._dynamicsLayer = new Sprite();
			this.addChild( this._dynamicsLayer );
		}

		public function createMap( mapData:MapDataVO ):void
		{
            var mapMatrix:Vector.<Vector.<MapNode>> = mapData.map;
            var homes:Vector.<HomeVO> = mapData.homes;
            var fruits:Vector.<IntPoint> = mapData.fruits;
			var forests:Vector.<IntPoint> = mapData.trees;

			var lineCount:int = mapMatrix.length;
			var colCount:int = mapMatrix[ 0 ].length;

			var backgroundBitmapData:BitmapData = new BitmapData( colCount * CMap.TILE_SIZE, lineCount * CMap.TILE_SIZE, false, 0 );
			backgroundBitmapData.lock();

			for( var i:int = 0; i < lineCount; i++ )
			{
				for( var j:int = 0; j < colCount; j++ )
				{
					this.drawTerrainToBitmapData( j, i, backgroundBitmapData, mapMatrix[ i ][ j ].baseType );
				}
			}

			backgroundBitmapData.unlock();

			this._staticLayer.addChild( new Bitmap( backgroundBitmapData ) );

			for each ( var home:HomeVO in homes )
			{
				this.createHome( home.pos );
			}

			for each ( var forest:IntPoint in forests )
			{
				this.createForest( forest );
			}

			for each ( var fruit:IntPoint in fruits )
			{
				this.createFruit( fruit );
			}

			this._terrainHelper.dispose();
		}

		private function createHome( pos:IntPoint ):void
		{
			var home:HomeView = this._dynamicsLayer.addChild( new HomeView() ) as HomeView;
			home.x = CMap.TILE_SIZE * pos.x;
			home.y = CMap.TILE_SIZE * pos.y;
		}

		public function createForest( pos:IntPoint ):void
		{
			var home:ForestView = this._dynamicsLayer.addChild( new ForestView() ) as ForestView;
			home.x = CMap.TILE_SIZE * pos.x;
			home.y = CMap.TILE_SIZE * pos.y;
		}

		public function createFruit( pos:IntPoint ):void
		{
			var home:FruitView = this._dynamicsLayer.addChild( new FruitView() ) as FruitView;
			home.x = CMap.TILE_SIZE * pos.x;
			home.y = CMap.TILE_SIZE * pos.y;
		}

		public function addUnit( villager:VillagerVO, pos:IntPoint ):void
		{
			var unit:DisplayObject = villager.view as DisplayObject;

			this._dynamicsLayer.addChild( unit );

			unit.x = CMap.TILE_SIZE * pos.x;
			unit.y = CMap.TILE_SIZE * pos.y;
		}

		private function drawTerrainToBitmapData( col:uint, row:uint, backgroundBitmapData:BitmapData, type:int ):void
		{
			var positionMatrix:Matrix = new Matrix();
			positionMatrix.tx = col * CMap.TILE_SIZE;
			positionMatrix.ty = row * CMap.TILE_SIZE;

			backgroundBitmapData.draw( this._terrainManifest[type], positionMatrix );
		}

		private function onEnterFrameHandler( event:Event ):void
		{
			this.zOrder();
		}

		private function zOrder():void
		{
			var child:DisplayObject;
			var childDatas:Array = [];

			for( var i:int = 0; i < this._dynamicsLayer.numChildren; i++ )
			{
				child = this._dynamicsLayer.getChildAt( i );

				childDatas.push( {child: child, y: child.y, x: child.x} );
			}

			childDatas.sortOn( 'y', Array.NUMERIC, 'x', Array.NUMERIC | Array.DESCENDING );

			for( i = 0; i < childDatas.length; i++ )
			{
				this._dynamicsLayer.addChild( childDatas[ i ].child );
			}
		}
	}
}
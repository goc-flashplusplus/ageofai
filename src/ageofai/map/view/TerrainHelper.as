/**
 * Created by newkrok on 08/04/16.
 */
package ageofai.map.view
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;

	public class TerrainHelper
	{
		private var _terrainGrassUI:BitmapData;
		private var _terrainDarkGrassUI:BitmapData;
		private var _terrainWaterUI:BitmapData;

		public function createBaseTerrainBitmapDatas():void
		{
			this._terrainGrassUI = this.createBitmapDataFromTerrainUI( TerrainGrassUI );
			this._terrainDarkGrassUI = this.createBitmapDataFromTerrainUI( TerrainDarkGrassUI );
			this._terrainWaterUI = this.createBitmapDataFromTerrainUI( TerrainWaterUI );
		}

		private function createBitmapDataFromTerrainUI( source:Class ):BitmapData
		{
			var terrainUI:DisplayObject = new source;
			var bitmapData:BitmapData = new BitmapData( terrainUI.width, terrainUI.height, false, 0 );
			bitmapData.draw( terrainUI );

			return bitmapData;
		}

		public function dispose():void
		{
			this._terrainGrassUI.dispose();
			this._terrainGrassUI = null;

			this._terrainDarkGrassUI.dispose();
			this._terrainDarkGrassUI = null;

			this._terrainWaterUI.dispose();
			this._terrainWaterUI = null;
		}

		public function get terrainGrassUI():BitmapData
		{
			return this._terrainGrassUI.clone();
		}

		public function get terrainDarkGrassUI():BitmapData
		{
			return this._terrainDarkGrassUI.clone();
		}

		public function get terrainWaterUI():BitmapData
		{
			return this._terrainWaterUI.clone();
		}
	}
}
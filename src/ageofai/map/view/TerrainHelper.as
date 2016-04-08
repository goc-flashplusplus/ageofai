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

		public function createBaseTerrainBitmapDatas():void
		{
			this._terrainGrassUI = this.createBitmapDataFromTerrainUI( TerrainGrassUI );
			this._terrainDarkGrassUI = this.createBitmapDataFromTerrainUI( TerrainDarkGrassUI );
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
		}

		public function get terrainGrassUI():BitmapData
		{
			return this._terrainGrassUI.clone();
		}

		public function get terrainDarkGrassUI():BitmapData
		{
			return this._terrainDarkGrassUI.clone();
		}
	}
}
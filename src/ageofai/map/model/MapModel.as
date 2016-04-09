/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.map.model
{
	import ageofai.fruit.vo.FruitVO;
	import ageofai.home.vo.HomeVO;
	import ageofai.map.astar.AStar;
	import ageofai.map.constant.CMap;
	import ageofai.map.constant.CMapNodeType;
	import ageofai.map.event.MapCreatedEvent;
	import ageofai.map.geom.IntPoint;
	import ageofai.map.vo.MapDataVO;
	import ageofai.unit.base.BaseUnitView;
	import ageofai.villager.view.VillagerView;

	import common.mvc.model.base.BaseModel;

	public class MapModel extends BaseModel implements IMapModel
	{

		private var _astarMap:GeneralAStarMap;
		private var _map:Vector.<Vector.<MapNode>>;
		private var _units:Vector.<Vector.<BaseUnitView>>;
		private var _homes:Vector.<HomeVO>;
		private var _fruits:Vector.<FruitVO>;
		private var _trees:Vector.<IntPoint>;

		public function get map():Vector.<Vector.<MapNode>>
		{
			return this._map;
		}

		public function get homes():Vector.<HomeVO>
		{
			return this._homes;
		}

		public function get fruits():Vector.<FruitVO>
		{
			return this._fruits;
		}

		public function get trees():Vector.<IntPoint>
		{
			return this._trees;
		}

		public function createMap( rowCount:int, columnCount:int ):void
		{
			this._map = new Vector.<Vector.<MapNode>>( rowCount, true );
			for( var i:int = 0; i < rowCount; i++ )
			{
				this._map[ i ] = new Vector.<MapNode>( columnCount, true );
				for( var j:int = 0; j < columnCount; j++ )
				{
					this._map[ i ][ j ] = this.getMapNode();
				}
			}

			// Get homes
			this._homes = this.getHomes( columnCount, rowCount );

			for each ( var home:HomeVO in this._homes )
			{
				for( i = home.pos.y; i < home.pos.y + 1; i++ )
				{
					for( j = home.pos.x; j < home.pos.x + 1; j++ )
					{
						this._map[ i ][ j ].objectType = CMapNodeType.OBJECT_HOME;
					}
				}
			}

			// Fruits
			 this._fruits = this.getFruits(columnCount, rowCount);

			 for each (var fruit:FruitVO in this._fruits)
			 {
			 this._map[fruit.pos.y][fruit.pos.x].objectType = CMapNodeType.OBJECT_FRUIT;
			 }

			 // Trees
			 this._trees = this.getTrees(columnCount, rowCount);

			 for each (var tree:IntPoint in this._trees)
			 {
			 this._map[ tree.y ][ tree.x ].objectType = CMapNodeType.OBJECT_TREE;
			 }

			this.eventDispatcher.dispatchEvent( new MapCreatedEvent( MapCreatedEvent.MAP_CREATED, this.getMapData() ) );
		}

		private function getHomes( columnCount:int, rowCount:int ):Vector.<HomeVO>
		{
			var homes:Vector.<HomeVO> = new Vector.<HomeVO>( CMap.HOME_COUNT, true );
			var minDistanceX:int = columnCount / CMap.HOME_COUNT;
			var minDistanceY:int = rowCount / CMap.HOME_COUNT;
			var offsetX:int, offsetY:int;
			do
			{
				offsetX = offsetY = 1;
				for( var i:int = 0; i < CMap.HOME_COUNT - 1; i++ )
				{
					var home:HomeVO = new HomeVO();
					home.pos = getRandomPoint( offsetX, offsetX += minDistanceX, offsetY, offsetY += minDistanceY );
					homes[ i ] = home;
				}
				home = new HomeVO();
				home.pos = getRandomPoint( offsetX, columnCount - 2, offsetY, rowCount - 2 );
				homes[ i ] = home;

				var isHomeInWalkableArea:Boolean = true;
				for( i = 0; i < CMap.HOME_COUNT; i++ )
				{
					if( this.isUnWalkablePointNextToIt( homes[ i ].pos ) )
					{
						isHomeInWalkableArea = false;
						break;
					}
				}

				if( !isHomeInWalkableArea )
				{
					continue;
				}

				// Make sure they are valid
				_astarMap = new GeneralAStarMap( _map );
				for( i = 0; i < CMap.HOME_COUNT; i++ )
				{
					if( this.isUnWalkablePointNextToIt( homes[ i ].pos ) )
					{
						break;
					}

					for( var j:int = 0; j < CMap.HOME_COUNT; j++ )
					{
                        if( i == j )
                        {
                            continue;
                        }
						var aStar:AStar = new AStar( _astarMap, homes[ i ].pos, homes[ j ].pos );
						var solution:Vector.<IntPoint> = aStar.solve();

                        if( solution )
                        {
                            break;
                        }
					}
                    if( !solution )
                    {
                        break;
                    }
				}
			}while( !solution );

			return homes;
		}

		private function isUnWalkablePointNextToIt( pos:IntPoint ):Boolean
		{
			var offsets:Array = [
				[ -1, -1 ], [ 0, -1 ], [ 1, -1 ], [ 2, -1 ],
				[ -1, 0 ], [ 0, 0 ],[ 1, 0 ],[ 2, 0 ],
				[ -1, 1 ], [ 0, 1 ],[ 1, 1 ],[ 2, 1 ],
				[ -1, 2 ], [ 0, 2 ], [ 1, 2 ], [ 2, 2 ],
			];

			for( var i:int = 0; i < offsets.length; i++ )
			{
				var colIndex:int = pos.y + offsets[ i ][ 0 ];
				var rowIndex:int = pos.x + offsets[ i ][ 1 ];

				if( colIndex >= 0 && rowIndex >= 0 && colIndex < this._map.length && rowIndex < this._map[ 0 ].length && this.isUnWalkablePoint( new IntPoint( colIndex, rowIndex ) ) )
				{
					return true;
				}
			}

			return false;
		}

		private function isUnWalkablePoint( pos:IntPoint ):Boolean
		{
			return !this._map[ pos.x ][ pos.y ].walkable;
		}

		private function getFruits( columnCount:int, rowCount:int ):Vector.<FruitVO>
		{
			var fruits:Vector.<FruitVO> = new Vector.<FruitVO>();
			for( var i:int = 0; i < CMap.HOME_COUNT; i++ )
			{
				var nearFruitsNo:int = Math.round( Math.random() * 4 ) + 2;

				for( var j:int = 0; j < nearFruitsNo; j++ )
				{
					do{
						var fruitX:int = Math.round( Math.random() * 8 ) + (this._homes[ i ].pos.x - 3);
						var fruitY:int = Math.round( Math.random() * 8 ) + (this._homes[ i ].pos.y - 3);
					}while( fruitX < 0 || fruitX >= columnCount || fruitY < 0 || fruitY >= rowCount
					|| (fruitX >= this._homes[ i ].pos.x && fruitX <= this._homes[ i ].pos.x + 2 && fruitY >= this._homes[ i ].pos.y && fruitY <= this._homes[ i ].pos.y + 2)
					|| !this._map[ fruitY ][ fruitX ].walkable
					|| this.isHomeInTheNear( fruitY, fruitX ) )

					fruits[ fruits.length ] = new FruitVO();
					fruits[ fruits.length - 1].pos = new IntPoint( fruitX, fruitY );
				}
			}

			var farFruitsNo:int = Math.round( Math.random() * 2 ) + 8;
			for( i = 0; i < farFruitsNo; i++ )
			{
				do{
					var fruitPos:IntPoint = getRandomPoint( 0, columnCount, 0, rowCount );
				}while( !this._map[ fruitPos.y ][ fruitPos.x ].walkable || distanceLessThan( 8, fruitPos ) )

				fruits[ fruits.length ] = new FruitVO();
				fruits[ fruits.length - 1].pos = fruitPos;
			}

			return fruits;
		}

		private function getTrees( columnCount:int, rowCount:int ):Vector.<IntPoint>
		{
			var trees:Vector.<IntPoint> = new Vector.<IntPoint>();
			for( var i:int = 0; i < CMap.HOME_COUNT; i++ )
			{
				var nearTreesNo:int = Math.round( Math.random() * 3 ) + 2;

				for( var j:int = 0; j < nearTreesNo; j++ )
				{
					do{
						var treeX:int = Math.round( Math.random() * 8 ) + (this._homes[ i ].pos.x - 3);
						var treeY:int = Math.round( Math.random() * 8 ) + (this._homes[ i ].pos.y - 3);
					}while( treeX < 0 || treeX >= columnCount || treeY < 0 || treeY >= rowCount
					|| (treeX >= this._homes[ i ].pos.x && treeX <= this._homes[ i ].pos.x + 2 && treeY >= this._homes[ i ].pos.y && treeY <= this._homes[ i ].pos.y + 2)
					|| !this._map[ treeY ][ treeX ].walkable
					|| this.isHomeInTheNear( treeY, treeX ) )

					trees[ trees.length ] = new IntPoint( treeX, treeY );
				}
			}

			var farTreesNo:int = Math.round( Math.random() * 2 ) + 14;
			for( i = 0; i < farTreesNo; i++ )
			{
				do{
					var treePos:IntPoint = getRandomPoint( 0, columnCount, 0, rowCount );
				}while( !this._map[ treePos.y ][ treePos.x ].walkable || distanceLessThan( 8, treePos ) )

				trees[ trees.length ] = treePos;
			}

			return trees;
		}

		private function isHomeInTheNear( col:uint, row:uint ):Boolean
		{
			var offsets:Array = [
				[ -1, -1 ], [ 0, -1 ], [ 1, -1 ],
				[ -1, 0 ], [ 0, 0 ], [ 1, 0 ],
				[ -1, 1 ], [ 0, 1 ], [ 1, 1 ]
			];

			for( var i:int = 0; i < offsets.length; i++ )
			{
				var colIndex:int = col + offsets[ i ][ 0 ];
				var rowIndex:int = row + offsets[ i ][ 1 ];

				if( this._map.length < rowIndex && rowIndex > 0
						&& this.map[ 0 ].length <= colIndex && colIndex > 0
						&& this._map[ colIndex ][ rowIndex ].objectType == CMapNodeType.OBJECT_HOME )
				{
					return true;
				}
			}

			return false;
		}

		/* INTERFACE ageofai.map.model.IMapModel */

		public function getMapData():MapDataVO
		{
			var mapData:MapDataVO = new MapDataVO();
			mapData.fruits = this._fruits;
			mapData.homes = this._homes;
			mapData.map = this._map;
			mapData.trees = this._trees;

			return mapData;
		}

		public function addUnit( villager:VillagerView ):void
		{
			if( !this._units )
			{
				this._units = new <Vector.<BaseUnitView>>[];
			}

			this._units.push( villager );

			this.eventDispatcher.dispatchEvent( new MapCreatedEvent( MapCreatedEvent.MAP_CREATED, this.getMapData() ) );
		}

		public function getPath( startPos:IntPoint, endPos:IntPoint ):Vector.<IntPoint>
		{
			var aStar:AStar = new AStar( this._astarMap, startPos, endPos );
			return aStar.solve();
		}

		private function getMapNode():MapNode
		{
			var rnd:Number = Math.random() * 100;
			var type:int;

			if( rnd <= 50 )
			{
				type = CMapNodeType.GRASS;
			}
			else if( rnd <= 95 )
			{
				type = CMapNodeType.DARK_GRASS;
			}
			else
			{
				type = CMapNodeType.WATER;
			}

			return new MapNode( type );
		}

		private function getRandomPoint( offsetX:int, limitX:int, offsetY:int, limitY:int ):IntPoint
		{
			var x:int = Math.random() * (limitX - offsetX) + offsetX;
			var y:int = Math.random() * (limitY - offsetY) + offsetY;

			return new IntPoint( x, y );
		}

		private function distanceLessThan( units:int, pos:IntPoint ):Boolean
		{
			for( var i:int = 0, count:int = this._homes.length; i < count; i++ )
			{
				if( Math.abs( pos.x - this._homes[ i ].pos.x ) + Math.abs( pos.y - this._homes[ i ].pos.y ) < units )
				{
					return true;
				}
			}
			return false;
		}
	}
}

/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.map.model
{
    import ageofai.home.vo.HomeVO;
    import ageofai.map.geom.IntPoint;
    import ageofai.map.vo.MapDataVO;
    public interface IMapModel
    {
        function get map():Vector.<Vector.<MapNode>>;

        function get homes():Vector.<HomeVO>;
        
        function createMap( rowCount:int, columnCount:int ):void;
        
        function getMapData():MapDataVO;
    }
}

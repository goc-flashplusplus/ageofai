/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.map.model
{
    import ageofai.map.geom.IntPoint;
    public interface IMapModel
    {
        function get map():Vector.<Vector.<MapNode>>;

        function get homes():Vector.<IntPoint>;
        
        function createMap( rowCount:int, columnCount:int ):void;
    }
}

/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.map.model
{
    public interface IMapModel
    {
        function get map():Vector.<Vector.<MapNode>>;

        function createMap( rowCount:int, columnCount:int ):void;

    }
}

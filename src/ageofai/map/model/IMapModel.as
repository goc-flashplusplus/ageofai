/**
 * Created by vizoli on 4/8/16.
 */
package ageofai.map.model
{
    public interface IMapModel
    {

        function createMap( columnCount:int, rowCount:int ):Vector.<Vector.<MapNode>>;

    }
}

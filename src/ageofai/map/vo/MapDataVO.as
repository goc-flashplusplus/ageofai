package ageofai.map.vo 
{
    import ageofai.map.geom.IntPoint;
    import ageofai.map.model.MapNode;
	/**
     * ...
     * @author 
     */
    public class MapDataVO 
    {
        public var map:Vector.<Vector.<MapNode>>;
        public var homes:Vector.<IntPoint>;
        public var fruits:Vector.<IntPoint>;
        public var trees:Vector.<IntPoint>;
    }

}
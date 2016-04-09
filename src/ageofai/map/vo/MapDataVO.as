package ageofai.map.vo 
{
    import ageofai.fruit.vo.FruitVO;
    import ageofai.home.vo.HomeVO;
    import ageofai.map.geom.IntPoint;
    import ageofai.map.model.MapNode;
	/**
     * ...
     * @author 
     */
    public class MapDataVO 
    {
        public var map:Vector.<Vector.<MapNode>>;
        public var homes:Vector.<HomeVO>;
        public var fruits:Vector.<FruitVO>;
        public var trees:Vector.<IntPoint>;
    }

}
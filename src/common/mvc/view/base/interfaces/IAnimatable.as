package common.mvc.view.base.interfaces
{
	
	/**
	 * Animatable object's interface.
	 * 
	 * @author vizoli
	 */
	public interface IAnimatable extends IView
	{
		
		function moveTo( toX:Number, toY:Number ):void;
		
	}
	
}
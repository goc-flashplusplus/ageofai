package common.mvc.model
{
	
	/**
	 * Statable interface.
	 * 
	 * @author vizoli
	 */
	public interface IStatable 
	{
		
		function set state( value:String ):void;
		
		function get state( ):String;
		
	}
	
}
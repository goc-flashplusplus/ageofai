package common.utils
{
	/**
	 * Math utils.
	 * 
	 * @author vizoli
	 */
	public class MathUtil 
	{
		
		/**
		 * Get a random int value between a range.
		 * 
		 * @param	minimum
		 * @param	maximum
		 * @return
		 */
		public static function getRandomIntInRange( minimum:Number, maximum:Number ):int
		{
			return ( Math.floor( Math.random() * ( maximum - minimum + 1 ) ) );
		}
		
		/**
		 * Get a random value between a range.
		 * 
		 * @param	minimum
		 * @param	maximum
		 * @return
		 */
		public static function getRandomInRange( minimum:Number, maximum:Number ):int
		{
			return ( Math.random() * ( maximum - minimum + 1 ) );
		}
		
	}

}
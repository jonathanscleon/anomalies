package general 
{
	import org.flixel.FlxPoint;
	/**
	 * This class keeps track of all the data
	 * that you want to maintain between states,
	 * but you don't want permamently saved.
	 * @author Jonathan Collins Leon
	 */
	public class TempSaveData 
	{
		// Keeps a list of all the glitches for the particular
		// area, and removes one every time the player defeats one.
		// The level will not display defeated glitches, until the player
		// leaves the area. Then they will reset.
		public static var glitchesLeft:Array = new Array();
		
		// The position that the player was in on the map
		// when the state changed.
		public static var lastPlayerPosition:FlxPoint = new FlxPoint();
		
		public function TempSaveData() 
		{
			
		}
		
	}

}
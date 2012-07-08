package general
{
	import org.flixel.*;
	import topdown.*;
	import general.scenes.*;

	/**
	 * State for actually playing the game
	 * @author Cody Sandahl
	 */
	public class PlayState extends FlxState
	{
		/**
		 * Constants
		 */
		public static var LEVEL_SIZE:FlxPoint = new FlxPoint(240, 240); // level size (in pixels)
		public static var BLOCK_SIZE:FlxPoint = new FlxPoint(16, 16); // block size (in pixels)
		
		/**
		 * Current level
		 * NOTE: "public static" allows us to get info about the level from other classes
		 */
		public static var LEVEL:TopDownLevel = null;
		
		override public function PlayState(level:TopDownLevel = null)
		{
			super();
			LEVEL = level;
		}
		
		/**
		 * Create state
		 */
		override public function create():void {
			FlxG.mouse.show();
			// load level
			if(LEVEL == null)
				LEVEL = new IndoorHouseLevel(this, LEVEL_SIZE, BLOCK_SIZE);
			this.add(LEVEL);
		}
	}
}

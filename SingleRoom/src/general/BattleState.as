package general
{
	import org.flixel.*;
	import topdown.*;
	import general.scenes.*;

	/**
	 * State for actually playing the game
	 * @author Cody Sandahl
	 */
	public class BattleState extends FlxState
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
		public static var LEVEL:TopDownBattlefield = null;
		private var lastLevel:TopDownLevel; // The level to return to when this battle is complete
		
		override public function BattleState(level:TopDownLevel)
		{
			super();
			lastLevel = level;
		}
		
		/**
		 * Create state
		 */
		override public function create():void {
			FlxG.mouse.show();
			// load level
			LEVEL = new NeutralBattleScene(this, LEVEL_SIZE, BLOCK_SIZE);
			this.add(LEVEL);
		}
		
		/**
		 * Returns to the previous state before
		 * the battle occurred.
		 */
		public function returnToPreviousState():void {
			FlxG.switchState(new PlayState(lastLevel));
		}
	}
}

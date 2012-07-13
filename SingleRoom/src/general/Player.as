package general 
{
	import flash.events.WeakFunctionClosure;
	import org.flixel.*;
	import org.flixel.dialog.*;
	import topdown.*;
	
	/**
	 * Player-controlled entity
	 * @author Cody Sandahl
	 */
	public class Player extends TopDownEntity
	{
		private static const SPEAKING_DISTANCE:uint = 10;
		
		public var speakingRange:FlxPoint;
		
		/**
		 * Constructor
		 * @param	X	X location of the entity
		 * @param	Y	Y location of the entity
		 */
		public function Player(X:Number=100, Y:Number=100):void {
			super(X, Y);
			loadGraphic(
				Assets.RANGER_SPRITE, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				TopDownEntity.SIZE.x, // width of each frame (in pixels)
				TopDownEntity.SIZE.y // height of each frame (in pixels)
			);
			speakingRange = new FlxPoint(X + this.width / 2, Y + this.height / 2);
		}
		
		/**
		 * Check for user input to control this entity
		 */
		override protected function updateControls():void {
			super.updateControls();
			// check keys
			// NOTE: this accounts for someone pressing multiple arrow keys at the same time (even in opposite directions)
			// Disable movement controls when speaking.
			if (!FlxDialog.LOCK_MOVEMENT)
			{
				var movement:FlxPoint = new FlxPoint();
				if (FlxG.keys.pressed(FlxControls.LEFT))
				{
					movement.x -= 1;
					speakingRange.x = this.x - SPEAKING_DISTANCE;
					speakingRange.y = this.y + this.height / 2;
				}
				if (FlxG.keys.pressed(FlxControls.RIGHT))
				{
					movement.x += 1;
					speakingRange.x = this.x + SPEAKING_DISTANCE;
					speakingRange.y = this.y + this.height / 2;
				}
				if (FlxG.keys.pressed(FlxControls.UP))
				{
					movement.y -= 1;
					speakingRange.x = this.x + this.width / 2;
					speakingRange.y = this.y - SPEAKING_DISTANCE;
				}
				if (FlxG.keys.pressed(FlxControls.DOWN))
				{
					movement.y += 1;
					speakingRange.x = this.x + this.width / 2;
					speakingRange.y = this.y + this.height + SPEAKING_DISTANCE;
				}
				// check final movement direction
				if (movement.x < 0)
					moveLeft();
				else if (movement.x > 0)
					moveRight();
				if (movement.y < 0)
					moveUp();
				else if (movement.y > 0)
					moveDown();
			}
		}
	}
}

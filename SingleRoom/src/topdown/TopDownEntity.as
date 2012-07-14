package topdown
{
	import org.flixel.*;
	import general.*;
	
	/**
	 * A moveable object in the game (player, enemy, NPC, etc)
	 * @author Jonathan S. Collins Leon
	 */
	public class TopDownEntity extends GenericInteractiveObject
	{
		/**
		 * Constants
		 */
		public static const RUNSPEED:int = 60;
		public static const SIZE:FlxPoint = new FlxPoint(16, 18); // size in pixels
		
		/**
		 * Constructor
		 * @param	X	X location of the entity
		 * @param	Y	Y location of the entity
		 */
		public function TopDownEntity(X:Number = 100, Y:Number = 100, asset:Class = null, dialogAsset:Class = null, dialogDisplayFunction:Function = null, dialogHideFunction:Function = null) 
		{
			super(X, Y, asset, dialogAsset, dialogDisplayFunction, dialogHideFunction);
			
			makeGraphic(SIZE.x, SIZE.y, 0xFFFF0000); // use this if you want a generic box graphic by default
			// movement
			this.maxVelocity = new FlxPoint(RUNSPEED, RUNSPEED);
			this.drag = new FlxPoint(RUNSPEED * 10, RUNSPEED * 10); // decelerate to a stop within 1/10 of a second
			// animations
			createAnimations();
		}
		
		/**
		 * Create the animations for this entity
		 * NOTE: these will be different if your art is different
		 */
		protected function createAnimations():void {
			this.addAnimation("idle_up", [1]);
			this.addAnimation("idle_right", [5]);
			this.addAnimation("idle_down", [9]);
			this.addAnimation("idle_left", [13]);
			this.addAnimation("walk_up", [0, 1, 2], 12); // 12 = frames per second for this animation
			this.addAnimation("walk_right", [4, 5, 6], 12);
			this.addAnimation("walk_down", [8, 9, 10], 12);
			this.addAnimation("walk_left", [12, 13, 14], 12);
			this.addAnimation("attack_up", [16, 17, 18, 19], 12, false); // false = don't loop the animation
			this.addAnimation("attack_right", [20, 21, 22, 23], 12, false);
			this.addAnimation("attack_down", [24, 25, 26, 27], 12, false);
			this.addAnimation("attack_left", [28, 29, 30, 31], 12, false);
		}

		/**
		 * Update each timestep
		 */
		public override function update():void {
			updateControls();
			updateAnimations();
			super.update();
		}
		
		/**
		 * Based on current state, show the correct animation
		 * FFV: use state machine if it gets more complex than this
		 */
		protected function updateAnimations():void {
			// use abs() so that we can animate for the dominant motion
			// ex: if we're moving slightly up and largely right, animate right
			var absX:Number = Math.abs(velocity.x);
			var absY:Number = Math.abs(velocity.y);
			// determine facing
			if (this.velocity.y < 0 && absY >= absX)
				this.facing = UP;
			else if (this.velocity.y > 0 && absY >= absX)
				this.facing = DOWN;
			else if (this.velocity.x > 0 && absX >= absY)
				this.facing = RIGHT;
			else if (this.velocity.x < 0 && absX >= absY)
				this.facing = LEFT
			// up
			if (this.facing == UP) {
				if (this.velocity.y != 0 || this.velocity.x != 0)
					this.play("walk_up");
				else
					this.play("idle_up");
			}
			// down
			else if (this.facing == DOWN) {
				if (this.velocity.y != 0 || this.velocity.x != 0)
					this.play("walk_down");
				else
					this.play("idle_down");
			}
			// right
			else if (this.facing == RIGHT) {
				if (this.velocity.x != 0)
					this.play("walk_right");
				else
					this.play("idle_right");
			}
			// left
			else if (this.facing == LEFT) {
				if (this.velocity.x != 0)
					this.play("walk_left");
				else
					this.play("idle_left");
			}
		}
		
		/**
		 * Check keyboard/mouse controls
		 */
		protected function updateControls():void {
			this.acceleration.x = this.acceleration.y = 0; // no gravity or drag by default
		}
		
		/**
		 * Move entity left
		 */
		public function moveLeft():void {
			this.facing = LEFT;
			this.velocity.x = -RUNSPEED; // accelerate to top speed in 1/4 of a second
		}
		
		/**
		 * Move entity right
		 */
		public function moveRight():void {
			this.facing = RIGHT;
			this.velocity.x = RUNSPEED; // accelerate to top speed in 1/4 of a second
		}
		
		/**
		 * Move entity up
		 */
		public function moveUp():void {
			this.facing = UP;
			this.velocity.y = -RUNSPEED; // accelerate to top speed in 1/4 of a second
		}
		
		/**
		 * Move playe rdown
		 */
		public function moveDown():void {
			this.facing = DOWN;
			this.velocity.y = RUNSPEED; // accelerate to top speed in 1/4 of a second
		}
	}
}

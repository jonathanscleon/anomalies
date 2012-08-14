package org.flixel
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import topdown.TopDownEntity;
	
	/**
	 * This class assists in creating the illusion of
	 * depth for any given map.
	 * @author	Jonathan S. Collins Leon
	 */
	public class FlxDepthMap extends FlxSprite
	{
		private const _white:uint = 0xffffff;
		public var maxZ:uint = 6;
		
		/**
		 * Creates a white 8x8 square <code>FlxSprite</code> at the specified position.
		 * Optionally can load a simple, one-frame graphic instead.
		 * 
		 * @param	X				The initial X position of the sprite.
		 * @param	Y				The initial Y position of the sprite.
		 * @param	SimpleGraphic	The graphic you want to display (OPTIONAL - for simple stuff only, do NOT use for animated images!).
		 */
		public function FlxDepthMap(depthMapGraphic:Class)
		{
			super(0, 0, depthMapGraphic);
			this.immovable = true;
			this.solid = false;
		}
		
		/**
		 * Creates the illusion of depth by scaling the given
		 * object depending on the loaded depth map.
		 * 
		 * @param	obj				The field object to be scaled.
		 */
		public function setDepth(obj:FlxSprite):void
		{
			// get center bottom of sprite, since we're defining how
			// the object walks around the field
			var centerBottomX:Number = obj.x + (obj.width / 2) * obj.scale.x;
			var centerBottomY:Number = obj.y + obj.height * obj.scale.y;
			
			// get the depth of the object's current position
			var color:uint = pixels.getPixel(centerBottomX, centerBottomY);
			var scale:Number = color / _white;
			
			// scale object based on depthmap to provide illusion of depth
			// if collided, ignore scale change
			if (scale != 0)
			{
				obj.scale.x = scale;
				obj.scale.y = scale;
			}
			// update z ordering
			obj.z = scale * maxZ;
		}
		
		/**
		 * Tests to see if the given object has tried to walk
		 * into an unwalkable area, as defined by the depth map.
		 * Unwalkable areas are any areas that have a color of 0x000000.
		 * 
		 * @param	obj				The field object to be tested.
		 * @return	Returns true if the sprite has reached an unwalkable area.
		 */
		public function collide(obj:FlxSprite):Boolean
		{
			// get collision point
			var collideX:Number = 0;
			var collideY:Number = obj.y + (obj.height * obj.scale.y);
			
			if (obj.facing == FlxObject.LEFT)
			{
				collideX = obj.x;
			}
			else if (obj.facing == FlxObject.RIGHT)
			{
				collideX = obj.x + (obj.width * obj.scale.x);
			}
			else if (obj.facing == FlxObject.UP)
			{
				collideX = obj.x + (obj.width / 2 * obj.scale.x);
				collideY -= 5;
			}
			else if (obj.facing == FlxObject.DOWN)
			{
				collideX = obj.x + (obj.width / 2 * obj.scale.x);
				collideY += 5;
			}
			
			var collided:Boolean = pixels.getPixel(collideX, collideY) == 0x000000;
			
			// stop object movement
			if (collided)
			{
				obj.touching |= obj.facing;
				obj.velocity.x = 0;
				obj.velocity.y = 0;
				obj.x = obj.last.x;
				obj.y = obj.last.y;
			}
			
			return collided;
		}
	}
}
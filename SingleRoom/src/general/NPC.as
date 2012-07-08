package general 
{
	import org.flixel.*;
	import topdown.*;
	/**
	 * AI-controlled entity
	 * @author Cody Sandahl
	 */
	public class NPC extends TopDownEntity
	{
		/**
		 * Constructor
		 * @param	X	X location of the entity
		 * @param	Y	Y location of the entity
		 */
		public function NPC(asset:Class, X:Number=100, Y:Number=100):void {
			super(X, Y);
			loadGraphic(
				asset, // image to use
				true, // animated
				false, // don't generate "flipped" images since they're already in the image
				TopDownEntity.SIZE.x, // width of each frame (in pixels)
				TopDownEntity.SIZE.y // height of each frame (in pixels)
			);
		}
	}
}

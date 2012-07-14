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
		public function NPC(X:Number, Y:Number, asset:Class, dialogAsset:Class = null, dialogDisplayFunction:Function = null, dialogHideFunction:Function = null) 
		{
			super(X, Y, asset, dialogAsset, dialogDisplayFunction, dialogHideFunction);
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

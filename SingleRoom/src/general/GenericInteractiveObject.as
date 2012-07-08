package general 
{
	import org.flixel.*;
	import general.DialogHandler;
	
	/**
	 * An interactable object in the game; no movement.
	 * @author Jonathan Collins Leon
	 */
	public class GenericInteractiveObject extends FlxSprite
	{
		private var dialogBox:FlxDialogWithOptions; // A 2D array; [i] is for the dialog, [i][j] is for the available response options, if any.
		private var dialogHandler:DialogHandler;
		//private var heldItem:Item;
		// Also handle events, like handing over items to the player and such
		
		public function GenericInteractiveObject(X:int, Y:int, asset:Class = null, dialogAsset:Class = null) 
		{
			super(X, Y, asset);
			dialogBox = new FlxDialogWithOptions();
			
			if (dialogAsset != null)
			{
				dialogHandler = new DialogHandler(dialogAsset);
				dialogHandler.load();
			}
		}
		
		public function showDialog():void
		{
			//return dialog;
		}
	}

}
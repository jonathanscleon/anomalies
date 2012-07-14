package general 
{
	import org.flixel.*;
	import org.flixel.dialog.FlxDialogHandler;
	import org.flixel.dialog.FlxDialogWithOptions;
	import org.osflash.signals.Signal;
	
	/**
	 * An interactable object in the game; no movement.
	 * @author Jonathan Collins Leon
	 */
	public class GenericInteractiveObject extends FlxSprite
	{
		private var _dialogHandler:FlxDialogHandler;
		
		// Also handle events, like handing over items to the player and such
		
		public function GenericInteractiveObject(X:int, Y:int, asset:Class = null, dialogAsset:Class = null, dialogDisplayFunction:Function = null, dialogHideFunction:Function = null) 
		{
			super(X, Y, asset);
			
			if (dialogAsset != null)
			{
				_dialogHandler = new FlxDialogHandler(dialogAsset);
				_dialogHandler.dialogStarted.add(dialogDisplayFunction);
				_dialogHandler.dialogFinished.add(dialogHideFunction);
				_dialogHandler.load();
			}
		}
		
		public function showDialog():void
		{
			_dialogHandler.startConversation();
		}
	}

}
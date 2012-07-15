package general 
{
	import org.flixel.*;
	import org.flixel.dialog.FlxDialogHandler;
	import org.flixel.dialog.FlxDialogWithOptions;
	import org.flixel.system.FlxHashMap;
	import org.osflash.signals.Signal;
	
	/**
	 * An interactable object in the game; no movement.
	 * @author Jonathan Collins Leon
	 */
	public class GenericInteractiveObject extends FlxSprite
	{
		private var _dialogHandler:FlxDialogHandler;
		
		public var properties:FlxHashMap;
		
		// Also handle events, like handing over items to the player and such
		
		public function GenericInteractiveObject(X:int, Y:int, asset:Class = null, dialogAsset:Class = null, dialogFileName:String = null, dialogDisplayFunction:Function = null, dialogHideFunction:Function = null) 
		{
			super(X, Y, asset);
			
			properties = new FlxHashMap();
			
			if (dialogAsset != null)
			{
				_dialogHandler = new FlxDialogHandler();
				_dialogHandler.dialogStarted.add(dialogDisplayFunction);
				_dialogHandler.dialogFinished.add(dialogHideFunction);
				_dialogHandler.load(dialogAsset, Assets.saveData, dialogFileName);
			}
		}
		
		public function showDialog():void
		{
			_dialogHandler.startConversation();
		}
	}

}
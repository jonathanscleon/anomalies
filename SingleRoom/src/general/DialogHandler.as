package general 
{
	import com.zach.datastructures.HashMap;
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Jonathan Collins Leon
	 */
	public class DialogHandler 
	{
		protected var statements:Array; // an array of dialog pieces
		protected var portraits:HashMap;
		protected var xmlHandler:FlxXML;
		protected var xml:XML;
		protected var savedIndex:uint;   // Saved index of where the player was last in the conversation.
		protected var savedSection:uint; // An index for which xml file to load for the character, 
										 // should the character's dialog be long enough for it to span
										 // multiple files.
		
		public function DialogHandler(asset:Class) 
		{
			xmlHandler = new FlxXML();
			xml = xmlHandler.loadEmbedded(asset);
			statements = new Array();
			portraits = new HashMap();
		}
		
		public function load(section:uint = 0, index:uint = 0):void
		{
			for each ( var data:XML in xml.statement.elements() )
			{
				var statement:DialogPiece = new DialogPiece(data);
				// portrait behavior: when showing dialog in FlxDialog,
				// and it attempts to get the portrait from the portraits
				// hashmap, using the string in the dialogpiece or dialogoption
				// object, if it returns a sprite from the hashmap, use it,
				// otherwise, load it.
			}
		}
		
		public function getDialog():Array
		{
			// @TODO
			return statements;
		}
		
		public function destroy():void
		{
			// @TODO
		}
	}

}
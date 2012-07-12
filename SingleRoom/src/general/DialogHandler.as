package general 
{
	import com.zach.datastructures.HashMap;
	import org.flixel.*;
	
	/**
	 * A class that provides an interface with which to load and display a character's dialog.
	 * @author Jonathan Collins Leon
	 */
	public class DialogHandler 
	{
		protected var conversations:Array; // an array of dialog pieces
		protected var portraits:HashMap; // @TODO: Move to Conversation class
		protected var xmlHandler:FlxXML;
		protected var dialogDisplay:FlxDialogWithOptions;
		protected var xml:XML;
		
		public function DialogHandler(asset:Class) 
		{
			xmlHandler = new FlxXML();
			xml = xmlHandler.loadEmbedded(asset);
			statements = new Array();
			portraits = new HashMap();
			dialogDisplay = new FlxDialogWithOptions();
		}
		
		public function load():void
		{
			conversations = new Array();
			// look at conversations
			for each ( var data:XML in xml.elements() )
			{
				var conversation:Conversation = new Conversation(data);
				
				conversations.push(conversation);
			}
		}
		
		public function startConversation():void
		{
			// look for an available conversation
			// display the given conversation
			// @TODO: extend this method to a new class, where
			// various types will be looked for, and the talkative
			// property will be used
			dialogDisplay.showDialog(getNextAvailableConversation());
		}
		
		// type: type of conversation to look up (casual, story, etc)
		public function getNextAvailableConversation(type:String = null):Conversation
		{
			for each( var dialog:Conversation in conversations )
			{
				if(Boolean(conversation.properties["enabled"]) && conversation.properties["type"] == type)
				{
					return dialog;
				}
			}
		}
		
		public function destroy():void
		{
			// @TODO
		}
	}

}
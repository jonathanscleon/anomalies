package org.flixel.dialog 
{
	import org.flixel.system.FlxHashMap;
	import org.flixel.*;
	
	/**
	 * A class that provides an interface with which to load and display a character's dialog.
	 * @author Jonathan Collins Leon
	 */
	public class FlxDialogHandler 
	{
		protected var _conversations:Array; // an array of dialog pieces
		protected var _portraits:FlxHashMap; // @TODO: Move to Conversation class
		protected var _xmlHandler:FlxXML;
		protected var _dialogDisplay:FlxDialogWithOptions;
		protected var _xml:XML;
		
		public function FlxDialogHandler(asset:Class) 
		{
			_xmlHandler = new FlxXML();
			_xml = _xmlHandler.loadEmbedded(asset);
			//_xml = new XML(new asset);
			_portraits = new FlxHashMap();
			_dialogDisplay = new FlxDialogWithOptions();
		}
		
		public function load():void
		{
			_conversations = new Array();
			// look at conversations
			for each ( var data:XML in _xml.elements() )
			{
				var conversation:FlxConversation = new FlxConversation(data);
				
				_conversations.push(conversation);
			}
		}
		
		public function startConversation():void
		{
			// look for an available conversation
			// display the given conversation
			// @TODO: extend this method to a new class, where
			// various types will be looked for, and the talkative
			// property will be used
			_dialogDisplay.showDialog(getNextAvailableConversation());
		}
		
		// type: type of conversation to look up (casual, story, etc)
		private function getNextAvailableConversation(type:String = null):FlxConversation
		{
			for each( var dialog:FlxConversation in _conversations )
			{
				var temp:String = dialog.properties.getItem("enabled") as String;
				var tempBool:Boolean = Boolean(temp);
				// @TODO: Use actual save data where null is
				//if(Boolean(dialog.properties.getItem("enabled")) && dialog.properties.getItem("type") == type && dialog.meetsPrerequisites(null))
				if(Boolean(dialog.properties.getItem("enabled")))
				{
					dialog.setVars(null);
					return dialog;
				}
			}
			
			return null;
		}
		
		public function destroy():void
		{
			// @TODO
		}
	}

}
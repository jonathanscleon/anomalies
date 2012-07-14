package org.flixel.dialog 
{
	import org.flixel.system.FlxHashMap;
	import org.flixel.*;
	import org.osflash.signals.Signal;
	
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
		
		public var dialogStarted:Signal;
		public var dialogFinished:Signal;
		
		public function FlxDialogHandler(asset:Class) 
		{
			_xmlHandler = new FlxXML();
			_xml = _xmlHandler.loadEmbedded(asset);
			_portraits = new FlxHashMap();
			_dialogDisplay = new FlxDialogWithOptions();
			_dialogDisplay.dialogStarted.add(onDialogStarted);
			_dialogDisplay.dialogFinished.add(onDialogFinished);
			dialogStarted = new Signal();
			dialogFinished = new Signal();
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
			if(!_dialogDisplay.showing)
				_dialogDisplay.showDialog(getNextAvailableConversation());
		}
		
		// type: type of conversation to look up (casual, story, etc)
		private function getNextAvailableConversation(type:String = null):FlxConversation
		{
			for each( var dialog:FlxConversation in _conversations )
			{
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
		
		private function onDialogStarted(dialog:FlxDialogWithOptions):void
		{
			dialogStarted.dispatch(dialog);
		}
		
		private function onDialogFinished(dialog:FlxDialogWithOptions):void
		{
			dialogFinished.dispatch(dialog);
		}
		
		public function destroy():void
		{
			// @TODO
		}
	}

}
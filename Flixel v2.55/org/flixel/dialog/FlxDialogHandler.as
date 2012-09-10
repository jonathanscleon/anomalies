package org.flixel.dialog 
{
	import flash.utils.ByteArray;
	import org.flixel.system.FlxHashMap;
	import org.flixel.*;
	import org.osflash.signals.Signal;
	import com.brokenfunction.json.decodeJson;
	import com.brokenfunction.json.encodeJson;
	
	/**
	 * A class that provides an interface with which to load and display a character's dialog.
	 * @author Jonathan Collins Leon
	 */
	public class FlxDialogHandler
	{
		protected var _conversations:FlxHashMap;
		protected var _dialogDisplay:FlxDialogWithOptions;
		protected var _saveData:FlxSaveExtended;
		protected var _fileName:String;
		
		public var dialogStarted:Signal;
		public var dialogFinished:Signal;
		
		/**
		 * Constructor
		 */
		public function FlxDialogHandler() 
		{	
			_dialogDisplay = new FlxDialogWithOptions();
			_dialogDisplay.dialogStarted.add(onDialogStarted);
			_dialogDisplay.dialogFinished.add(onDialogFinished);
			dialogStarted = new Signal();
			dialogFinished = new Signal();
		}
		
		/**
		 * Loads all dialog data for a particular file
		 * @param	asset		Class containing a reference to embedded json data.
		 * @param	saveData	Save data, used to load modified dialog data.
		 * @param	file		File to load
		 */
		public function load(asset:Class, saveData:FlxSaveExtended, file:String):void
		{
			// If conversation data is available, load it
			// @TODO: Save/load conversation data. Remember that any variables that are not public will not be saved.
			if( saveData.data.conversationFiles.getItem(file) != null)
				_conversations = saveData.loadConversationData(file);
			else
			{
				_conversations = new FlxHashMap();
				
				// load json data
				// using actionjson for speed; uses native json loading if available
				var bytes:ByteArray = new asset() as ByteArray;
				var json:Object = decodeJson(bytes.readUTFBytes(bytes.length));
				
				// load conversations
				for (var i:uint = 0; i < json.conversations.length; i++)
				{
					_conversations.insert(json.conversations[i].properties.id, new FlxConversation(json.conversations[i]));
				}
			}
			
			_fileName = file;
		}
		
		/**
		 * Initiates a conversation. Chooses a topic of conversation
		 * and displays it.
		 */
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
		/**
		 * @TODO This is the desired functionality for the sub class
		 * Gets the next available conversation based on the type of conversation desired.
		 * @param	type
		 * @return
		 
		private function getNextAvailableConversation(type:String = null):FlxConversation
		*/
		/**
		 * Gets the next available conversation.
		 * @return
		 */
		private function getNextAvailableConversation():FlxConversation
		{
			for each( var dialog:FlxConversation in _conversations )
			{
				// @TODO: Use actual save data where null is
				//if(Boolean(dialog.properties.getItem("enabled")) && dialog.properties.getItem("type") == type && dialog.meetsPrerequisites(null))
				if(Boolean(dialog.properties.enabled))
				{
					dialog.setVars(null);
					return dialog;
				}
			}
			
			return null;
		}
		
		public function getConversationByID(id:String):FlxConversation
		{
			return _conversations.getItem(id) as FlxConversation;
		}
		
		private function onDialogStarted(dialog:FlxDialogWithOptions):void
		{
			dialogStarted.dispatch(dialog);
		}
		
		private function onDialogFinished(dialog:FlxDialogWithOptions):void
		{
			// call conversation's setvars somehow
			dialogFinished.dispatch(dialog);
		}
		
		public function destroy():void
		{
			// @TODO
		}
	}

}
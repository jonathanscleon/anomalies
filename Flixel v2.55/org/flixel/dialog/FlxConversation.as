package org.flixel.dialog
{
	import org.flixel.system.FlxHashMap;
	import org.flixel.*;

	/**
	* This class manages a single conversation.
	* @author Jonathan Collins Leon
	*/
	public class FlxConversation
	{
		/*
		 * json object containing conversation data
		 */
		protected var _data:Object;
		
		/**
		 * Hashmap of FlxSprites
		 */
		protected var _portraits:FlxHashMap;
		
		/**
		 * Hashmap of statements
		 */
		protected var _statements:FlxHashMap;
		
		/**
		 * The statement currently in use
		 */
		protected var _currentDialog:FlxDialogPiece;
		
		/**
		 * Constructor
		 * @param	data	json object containing conversation data
		 */
		public function FlxConversation(data:Object)
		{
			_portraits = new FlxHashMap();
			_statements = new FlxHashMap();
			
			loadData(data);
		}
		
		/**
		 * Loads conversation data.
		 * @param	data	json object containing conversation data
		 */
		private function loadData(data:Object):void
		{
			_data = data;
			_currentDialog = new FlxDialogPiece(data.statements[0]);
			
			for (var i:uint = 0; i < data.statements.length; i++)
			{
				var dialogPiece:FlxDialogPiece = new FlxDialogPiece(data.statements[i]);
				dialogPiece.getPortrait.add(getPortrait);
				_statements.insert(data.statements[i].label, dialogPiece);
			}
			
			// remove redundant data
			_data.statements = null;
		}
		
		public function get properties():Object
		{
			return _data.properties;
		}
		
		public function getCurrentStatement():FlxDialogPiece
		{
			return _currentDialog;
		}
		
		/**
		 * Get the next statement in the conversation, based
		 * on the given statement label.
		 * @param	goto	The label to look for for the next statement.
		 * @return
		 */
		public function getNextStatement(goto:String):FlxDialogPiece
		{
			if (goto.length > 0)
			{
				_currentDialog = _statements.getItem(goto) as FlxDialogPiece;
				return _currentDialog;
			}
			else
			{
				return null;
			}
		}
		
		/**
		 * Returns a portrait sprite based on the given label,
		 * or loads a portrait sprite and returns it if one is
		 * not already available.
		 * @param	label	The label of the portrait to look for
		 * @return	Returns a FlxSprite of the requested sprite
		 */
		public function getPortrait(label:String):FlxSprite
		{
			if(_portraits.getItem(label) != null)
			{
				return _portraits.getItem(label) as FlxSprite;
			}
			else
			{
				// load embedded image
				//_portraits.insert(label, image);
				//return image;
				return null;
			}
		}
		
		/**
		 * Checks to see if the player's game state
		 * meets the prerequisites for the conversation
		 * to occur.
		 * @return Returns true if it does meet the prerequisites
		 */
		public function meetsPrerequisites():Boolean
		{
			if(_data.prerequisites != null)
			{
				// @TODO
				return true;
			}
			else
			{
				return true;
			}
		}
		
		/**
		 * Updates variables and saves them to AutoSave
		 * @param	saveData	The save object to save the data to
		 */
		public function setVars(saveData:FlxSaveExtended):void
		{
			// @TODO
			if(_data.setvars != null && _data.setvars.conversation != null)
			{
				
			}
		}
	}
}
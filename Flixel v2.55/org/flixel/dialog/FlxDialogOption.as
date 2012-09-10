package org.flixel.dialog 
{
	import org.flixel.*;
	import org.flixel.system.FlxHashMap;
	
	/**
	 * Handles the data for a set of dialog options,
	 * a subset of a statement, which is a subset
	 * of a conversation.
	 * @author Jonathan Collins Leon
	 */
	public class FlxDialogOption 
	{
		protected var _data:Object;
		
		/**
		 * Constructor
		 * @param	option	json data containing data for a set of dialog options
		 */
		public function FlxDialogOption(option:Object) 
		{
			loadData(option);
		}
		
		/**
		 * Loads dialog option data
		 * @param	option	json data containing data for a set of dialog options
		 */
		private function loadData(data:Object):void
		{
			_data = data;
		}
		
		/**
		 * Checks to see if the player's game state
		 * meets the prerequisites for this dialog
		 * option to be available.
		 * @return	Returns true if it meets the prerequisites
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
		 * Updates any variables and saves them to AutoSave
		 * @param	saveData	The save object to save the data to
		 */
		public function setVars(saveData:FlxSave):void
		{
			// @TODO
			if(_data.prerequisites != null)
			{
				
			}
		}
		
		public function get text():String
		{
			return _data.text;
		}
		
		public function get goto():String
		{
			return _data.goto;
		}
	}

}
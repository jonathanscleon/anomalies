package org.flixel 
{
	import org.flixel.dialog.FlxConversation;
	import org.flixel.system.FlxHashMap;
	
	/**
	 * ...
	 * @author ...
	 */
	public class FlxSaveExtended extends FlxSave 
	{
		
		public function FlxSaveExtended() 
		{
			
		}
		
		/**
		 * @TODO
		 * @return
		 */
		public function loadConversationData(file:String):FlxHashMap
		{
			return  this.data.conversationFiles.getItem(file);
		}
		
		/**
		 * @TODO
		 * @param	data
		 */
		public function saveConversationData(file:String, data:FlxConversation):void
		{
			
		}
	}

}
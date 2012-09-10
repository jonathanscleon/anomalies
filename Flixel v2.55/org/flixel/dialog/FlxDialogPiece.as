package org.flixel.dialog 
{
	import org.flixel.*;
	import org.osflash.signals.*;
	
	/**
	 * This class handles a single statement, a subset
	 * of a conversation.
	 * @author Jonathan Collins Leon
	 */
	public class FlxDialogPiece 
	{
		/**
		 * json object containing statement data
		 */
		protected var _data:Object;
		
		/**
		 * Contains an array of FlxDialogPieces
		 */
		public var options:Array;
		
		public var portraitImage:FlxSprite;
		public var gotoStatement:Signal; // unused
		
		/**
		 * Used to request portraits
		 */
		public var getPortrait:Signal;
		
		/**
		 * Constructor
		 * @param	data	json object containing data for a single statement
		 */
		public function FlxDialogPiece(data:Object) 
		{
			gotoStatement = new Signal();
			getPortrait = new Signal();
			load(data);
		}
		
		/**
		 * Loads all statement data, as well as
		 * any available dialog options.
		 * @param	data	json object containing data for a single statement
		 */
		public function load(data:Object):void
		{
			options = new Array();
			_data = data;
			
			if (data.options != null)
			{
				for (var i:uint = 0; i < data.options.length; i++)
				{
					options.push(new FlxDialogOption(data.options[i]));
				}
			}
			
			// remove redundant data
			_data.options = null;
			
			// request portrait
			getPortrait.dispatch(data.portrait);
		}
		
		public function get label():String
		{
			return _data.label;
		}
		
		public function get name():String
		{
			return _data.name;
		}
		
		public function get portrait():String
		{
			return _data.portrait;
		}
		
		public function get text():String
		{
			return _data.text;
		}
		
		public function get goto():String
		{
			return _data.goto;
		}
		
		public function destroy():void
		{
			
		}
	}

}
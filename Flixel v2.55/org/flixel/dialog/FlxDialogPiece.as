package org.flixel.dialog 
{
	import org.flixel.*;
	import org.osflash.signals.*;
	
	/**
	 * ...
	 * @author Jonathan Collins Leon
	 */
	public class FlxDialogPiece 
	{
		public var label:String;
		public var name:String;
		public var portrait:String;
		public var text:String;
		public var goto:String;
		public var options:Array; // an array of dialog options
		public var portraitImage:FlxSprite;
		public var gotoStatement:Signal;
		public var getPortrait:Signal;
		
		public function FlxDialogPiece(data:XML) 
		{
			gotoStatement = new Signal();
			getPortrait = new Signal();
			load(data);
		}
		
		public function load(data:XML):void
		{
			label = data.label;
			name = data.name;
			portrait = data.portrait;
			text = data.text;
			goto = data.goto;
			options = new Array();
			
			if(data.option_container != null)
			{
				for each( var option:XML in data.option_container.elements() )
				{
					options.push(new FlxDialogOption(option));
				}
			}
			
			getPortrait.dispatch(portrait);
		}
		
		public function destroy():void
		{
			
		}
	}

}
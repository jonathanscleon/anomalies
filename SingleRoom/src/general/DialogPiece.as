package general 
{
	import org.flixel.*;
	import <Signals>;
	
	/**
	 * ...
	 * @author Jonathan Collins Leon
	 */
	public class DialogPiece 
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
		
		public function DialogPiece(data:XML) 
		{
			getNextStatement = new Signal();
			getPortrait = new Signal();
			load(data);
		}
		
		public function load(data:XML):void
		{
			label = data.label;
			name = data.name;
			portrait = data.portrait;
			text = data.text;
			options = new Array();
			
			if(data.option_container != null)
			{
				for each( var option:XML in data.option_container.elements() )
				{
					options.push(new DialogOption(option));
				}
			}
			else
			{
				goto = data.goto;
			}
			
			getPortrait.dispatch(portrait);
		}
		
		public function onFinished():void
		{
			gotoStatement.dispatch(goto);
		}
		
		public function destroy():void
		{
			
		}
	}

}
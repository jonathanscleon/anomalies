package general 
{
	import org.flixel.*;
	
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
		
		public function DialogPiece(data:XML) 
		{
			load(data);
		}
		
		public function load(data:XML):void
		{
			label = data.label;
			name = data.name;
			portrait = data.portrait;
			text = data.text;
			options = new Array();
			
			var optionGoTo:String;
			var optionPortrait:String;
			var response:Array = new Array();
			for each( var xmlOptions:XML in data.option_container.elements() )
			{
				optionGoTo = "";
				optionPortrait = "";
				response = new Array();
				
				if (xmlOptions.goto != null)
					optionGoTo = xmlOptions.goto;
				if (xmlOptions.portrait != null)
					optionPortrait = xmlOptions.portrait;
				if (xmlOptions.text != null)
					response.push(xmlOptions.text);
				else if (xmlOptions.response != null)
				{
					for each( var xmlResponses:XML in xmlOptions.response.elements() )
						response.push(xmlResponses);
				}
				
				options.push(new DialogOption(xmlOptions.@choice_text, optionGoTo, optionPortrait, response));
			}
		}
		
		public function destroy():void
		{
			
		}
	}

}
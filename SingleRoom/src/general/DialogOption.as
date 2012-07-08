package general 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Jonathan Collins Leon
	 */
	public class DialogOption 
	{
		public var text:String;		// the text for the choice
		public var goto:String;
		public var gotoFile:String;
		
		public function DialogOption(text:String, goto:String, gotoFile:String) 
		{
			this.text = text;
			this.goto = goto;
			this.gotoFile = gotoFile;
		}
	}

}
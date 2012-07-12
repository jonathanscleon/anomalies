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
		private var prerequisites:HashMap;
		private var varsToSet:HashMap;
		
		public function DialogOption(option:XML) 
		{
			prerequisites = new HashMap();
			varsToSet = new HashMap();
			loadData(option);
		}
		
		private function loadData(data:XML):void
		{
			text = data.@choice_text;
			goto = data.goto;
			
			for each ( var xmlPrerequisites:XML in data.prerequisites.attributes() )
			{
				prerequisites.put(xmlPrerequisites.name(), xmlPrerequisites.valueOf());
			}
			
			for each ( var xmlVarsToSet:XML in data.setVars.attributes() )
			{
				varsToSet.put(xmlVarsToSet.name(), xmlVarsToSet.valueOf());
			}
		}
		
		public function meetsPrerequisites(saveData:SaveData):bool
		{
			if(prerequisites.size() > 0)
			{
				// @TODO
				return true;
			}
			else
			{
				return true;
			}
		}
		
		public function setVars(saveData:SaveData):void
		{
			// @TODO
			if(varsToSet.size() > 0)
			{
				
			}
		}
	}

}
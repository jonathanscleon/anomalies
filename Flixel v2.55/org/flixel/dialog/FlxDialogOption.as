package org.flixel.dialog 
{
	import org.flixel.*;
	import org.flixel.system.FlxHashMap;
	
	/**
	 * ...
	 * @author Jonathan Collins Leon
	 */
	public class FlxDialogOption 
	{
		public var text:String;		// the text for the choice
		public var goto:String;
		private var _prerequisites:FlxHashMap;
		private var _varsToSet:FlxHashMap;
		
		public function FlxDialogOption(option:XML) 
		{
			_prerequisites = new FlxHashMap();
			_varsToSet = new FlxHashMap();
			loadData(option);
		}
		
		private function loadData(data:XML):void
		{
			text = data.@choice_text;
			goto = data.goto;
			
			for each ( var xmlPrerequisites:XML in data.prerequisites.attributes() )
			{
				_prerequisites.insert(xmlPrerequisites.name(), xmlPrerequisites.toString());
			}
			
			for each ( var xmlVarsToSet:XML in data.setVars.attributes() )
			{
				_varsToSet.insert(xmlVarsToSet.name(), xmlVarsToSet.toString());
			}
		}
		
		public function meetsPrerequisites(saveData:FlxSave):Boolean
		{
			if(_prerequisites.size() > 0)
			{
				// @TODO
				return true;
			}
			else
			{
				return true;
			}
		}
		
		public function setVars(saveData:FlxSave):void
		{
			// @TODO
			if(_varsToSet.size() > 0)
			{
				
			}
		}
	}

}
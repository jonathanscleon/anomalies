package org.flixel.dialog
{
	import org.flixel.system.FlxHashMap;
	import org.flixel.*;

	/**
	* ...
	* @author Jonathan Collins Leon
	*/
	public class FlxConversation
	{
		public var properties:FlxHashMap;
		protected var _prerequisites:FlxHashMap;
		protected var _varsToSet:FlxHashMap;
		protected var _portraits:FlxHashMap;
		protected var _statements:FlxHashMap; // holds an array of Dialog Pieces
		protected var _currentDialog:FlxDialogPiece;

		public function FlxConversation(data:XML)
		{
			properties = new FlxHashMap();
			_prerequisites = new FlxHashMap();
			_varsToSet = new FlxHashMap();
			_portraits = new FlxHashMap();
			_statements = new FlxHashMap();
			
			loadData(data);
		}
		
		private function loadData(data:XML):void
		{
			for each ( var xmlProperties:XML in data.properties.attributes() )
			{
				properties.insert(xmlProperties.name(), xmlProperties.toString());
			}
			
			for each ( var xmlPrerequisites:XML in data.prerequisites.attributes() )
			{
				_prerequisites.insert(xmlPrerequisites.name(), xmlPrerequisites.toString());
			}
			
			for each ( var xmlVarsToSet:XML in data.setVars.attributes() )
			{
				_varsToSet.insert(xmlVarsToSet.name(), xmlVarsToSet.toString());
			}
			
			// now to load the actual dialog
			// look at statements
			for each ( var xmlStatement:XML in data.statements.elements() )
			{
				var statement:FlxDialogPiece = new FlxDialogPiece(xmlStatement);
				
				// establish opening dialog
				if(_currentDialog == null)
				{
					_currentDialog = statement;
				}
				
				_statements.insert(xmlStatement.label, statement);
			}
		}

		public function loadListeners():void
		{
			for each(var statement:FlxDialogPiece in _statements)
			{
				// provide method for loading portraits, but not
				// loading the same portrait multiple times
				statement.getPortrait.add(getPortrait);
			}
		}
		
		public function getCurrentStatement():FlxDialogPiece
		{
			return _currentDialog;
		}
		
		public function getNextStatement():FlxDialogPiece
		{
			if(_currentDialog.goto != null)
			{
				_currentDialog = _statements.getItem(_currentDialog.goto) as FlxDialogPiece;
				return _currentDialog;
			}
			else
			{
				return null;
			}
		}
		
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
		
		public function meetsPrerequisites(saveData:FlxSave):Boolean
		{
			if(_prerequisites.size > 0)
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
			if(_varsToSet.size > 0)
			{
				
			}
		}
	}
}
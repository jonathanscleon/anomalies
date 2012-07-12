package general
{
  import com.zach.datastructures.HashMap;
  import org.flixel.*;
  
  /**
  * ...
  * @author Jonathan Collins Leon
  */
  public class Conversation
  {
    public properties:HashMap;
    private prerequisites:HashMap;
    private varsToSet:HashMap;
    private portraits:HashMap;
    private statements:HashMap; // holds an array of Dialog Pieces
    private currentDialog:DialogPiece;
    
    public function Conversation(data:XML)
    {
      properties = new HashMap();
      prerequisites = new HashMap();
      varsToSet = new HashMap();
      portraits = new HashMap();
      statements = new HashMap();
      
      loadData(data);
    }
    
    private function loadData(data:XML):void
    {
    	for each ( var xmlProperties:XML in data.properties.attributes() )
	{
		properties.put(xmlProperties.name(), xmlProperties.valueOf());
	}

	for each ( var xmlPrerequisites:XML in data.prerequisites.attributes() )
	{
		prerequisites.put(xmlPrerequisites.name(), xmlPrerequisites.valueOf());
	}

	for each ( var xmlVarsToSet:XML in data.setVars.attributes() )
	{
		varsToSet.put(xmlVarsToSet.name(), xmlVarsToSet.valueOf());
	}
	
	// now to load the actual dialog
	// look at statements
	for each ( var xmlStatement:XML in data.statements.elements() )
	{
		var statement = new DialogPiece(xmlStatement);
		
		// establish opening dialog
		if(currentDialog == null)
		{
			currentDialog = statement;
		}

		statements.put(xmlStatement.label, statement);
	}
    }
    
    public function loadListeners():void
    {
      for each(var statement:DialogPiece in statements)
      {
	// provide method for loading portraits, but not
	// loading the same portrait multiple times
        statement.getPortrait.add(getPortrait);
      }
    }
    
	public function getCurrentStatement():DialogPiece
	{
		return currentDialog;
	}
	
    public function getNextStatement():DialogPiece
    {
	if(currentDialog.goto != null)
	{
		currentDialog = statements.get(currentDialog.goto);
      		return currentDialog;
	}
	else
	{
		return null;
	}
    }
    
    public function getPortrait(label:String):FlxImage
    {
      if(portrait.get(label) != null)
      {
        return portrait.get(label);
      }
      else
      {
        // load embedded image
        portrait.put(label, image);
        return image;
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
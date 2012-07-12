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
		// portrait behavior: when showing dialog in FlxDialog,
		// and it attempts to get the portrait from the portraits
		// hashmap, using the string in the dialogpiece or dialogoption
		// object, if it returns a sprite from the hashmap, use it,
		// otherwise, load it.

		statements.put(xmlStatement.label, new DialogPiece(xmlStatement));
	}
    }
    
    public function loadListeners():void
    {
      for each(var statement:DialogPiece in statements)
      {
        statement.gotoStatement.add(getNextStatement);
        statement.getPortrait.add(getPortrait);
      }
    }
    
    public function getNextStatement(goto:String):DialogPiece
    {
      return statements.get(goto);
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
  }
}
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
    public prerequisites:HashMap;
    public varsToSet:HashMap;
    public portraits:HashMap;
    public statements:HashMap; // holds an array of Dialog Pieces
    
    public function Conversation()
    {
      properties = new HashMap();
      prerequisites = new HashMap();
      varsToSet = new HashMap();
      portraits = new HashMap();
      statements = new HashMap();
    }
    
    public function loadListeners():void
    {
      for each(var statement:DialogPiece in statements)
      {
        statement.getNextStatement.add(getNextStatement);
        statement.getPortrait.add(getPortrait);
      }
    }
    
    public function getNextStatement(goto:String):DialogPiece
    {
      return statements[goto];
    }
    
    public function getPortrait(label:String):FlxImage
    {
      return portrait[label];
    }
  }
}
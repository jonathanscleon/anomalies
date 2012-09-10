package general
{
	import flash.utils.ByteArray;
	import org.flixel.FlxSaveExtended;
	import org.flixel.system.FlxHashMap;
	/**
	 * Embeds and imports all assets for the game
	 * @author Cody Sandahl
	 */
	public class Assets
	{
		public static var saveData:FlxSaveExtended;
		
		public static function loadSaveData():void
		{
			saveData = new FlxSaveExtended();
			var loaded:Boolean = saveData.bind("AnomaliesTestSaveData");
			if (loaded && saveData.data.saved == null)
			//if(loaded)
			{
				// Change save data so that all saves are done at the character level.
				// A character will have a list of unavailable conversations, as well as other properties, such as knowledge about the character
				// What to do about player level data...
				// init save data if none available
				saveData.data.saved = true;
				saveData.data.tempInitVar = false;
				saveData.data.likesSquares = false;
				saveData.data.conversationFiles = new FlxHashMap();
			}
		}
		
		// sprites
		[Embed(source = "../../assets/sprites/avatar.png")] public static var PLAYER_SPRITE:Class;
		[Embed(source = "../../assets/sprites/npc.png")] public static var NPC_SPRITE:Class;
		[Embed(source = "../../assets/sprites/ranger (opengameart - Antifarea - ccby30).png")] public static var RANGER_SPRITE:Class;
		[Embed(source = "../../assets/sprites/rug1 (opengameart - Redshrike - ccby30).png")] public static var RUG1_SPRITE:Class;
		[Embed(source = "../../assets/sprites/rug2 (opengameart - Redshrike - ccby30).png")] public static var RUG2_SPRITE:Class;
		[Embed(source = "../../assets/sprites/bookcase (opengameart - Redshrike - ccby30).png")] public static var BOOKCASE_SPRITE:Class;
		[Embed(source = "../../assets/sprites/chair_down (opengameart - Redshrike - ccby30).png")] public static var CHAIRDOWN_SPRITE:Class;
		[Embed(source = "../../assets/sprites/chair_left (opengameart - Redshrike - ccby30).png")] public static var CHAIRLEFT_SPRITE:Class;
		[Embed(source = "../../assets/sprites/chair_right (opengameart - Redshrike - ccby30).png")] public static var CHAIRRIGHT_SPRITE:Class;
		[Embed(source = "../../assets/sprites/chair_up (opengameart - Redshrike - ccby30).png")] public static var CHAIRUP_SPRITE:Class;
		[Embed(source = "../../assets/sprites/table_round (opengameart - Redshrike - ccby30).png")] public static var TABLEROUND_SPRITE:Class;
		[Embed(source = "../../assets/sprites/armor (opengameart - Redshrike - ccby30).png")] public static var ARMOR_SPRITE:Class;
		[Embed(source = "../../assets/sprites/bed (opengameart - Redshrike - ccby30).png")] public static var BED_SPRITE:Class;
		
		// background
		[Embed(source = "../../assets/backgrounds/back_1.png")] public static var MARKET_1:Class;
		[Embed(source = "../../assets/backgrounds/back_2.png")] public static var MARKET_2:Class;
		[Embed(source = "../../assets/backgrounds/back_3.png")] public static var MARKET_3:Class;
		[Embed(source = "../../assets/backgrounds/back_4.png")] public static var MARKET_4:Class;
		[Embed(source = "../../assets/backgrounds/back_5.png")] public static var MARKET_5:Class;
		[Embed(source = "../../assets/backgrounds/depthmap.png")] public static var MARKET_DEPTHMAP:Class;

		// tiles
		[Embed(source = "../../assets/tiles/walls (opengameart - daniel siegmund - ccby30).png")] public static var WALLS_TILE:Class;
		[Embed(source = "../../assets/tiles/floor_wood (opengameart - Redshrike - ccby30).png")] public static var FLOORS_TILE:Class;
		
		// dialog
		//[Embed(source = "../../assets/dialog/locations/IndoorHouseLevel/armor.xml")] public static var INDOOR_HOUSE_LEVEL_ARMOR:Class;
		//[Embed(source = "../../assets/dialog/locations/IndoorHouseLevel/bookcase.xml")] public static var INDOOR_HOUSE_LEVEL_BOOKCASE:Class;
		[Embed(source = "../../assets/dialog/characters/testnpc.xml", mimeType = "application/octet-stream")] public static var TEST_NPC_DIALOG_0:Class;
		[Embed(source = "../../assets/dialog/characters/testnpc.json", mimeType="application/octet-stream")] public static var TEST_NPC_DIALOG_1:Class;
	}
}

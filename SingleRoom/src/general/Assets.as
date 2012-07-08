package general
{
	import flash.utils.ByteArray;
	/**
	 * Embeds and imports all assets for the game
	 * @author Cody Sandahl
	 */
	public class Assets
	{
		// sprites
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

		// tiles
		[Embed(source = "../../assets/tiles/walls (opengameart - daniel siegmund - ccby30).png")] public static var WALLS_TILE:Class;
		[Embed(source = "../../assets/tiles/floor_wood (opengameart - Redshrike - ccby30).png")] public static var FLOORS_TILE:Class;
		
		// dialog
		[Embed(source = "../../assets/dialog/locations/IndoorHouseLevel/armor.xml")] public static var INDOOR_HOUSE_LEVEL_ARMOR:Class;
		[Embed(source = "../../assets/dialog/locations/IndoorHouseLevel/bookcase.xml")] public static var INDOOR_HOUSE_LEVEL_BOOKCASE:Class;
		[Embed(source = "../../assets/dialog/characters/testnpc.xml")] public static var TEST_NPC:Class;
	}
}

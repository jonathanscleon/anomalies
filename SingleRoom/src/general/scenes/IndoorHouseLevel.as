package general.scenes
{
	import org.flixel.*;
	import topdown.*;
	import general.*;
	
	/**
	 * A basic indoor scene
	 * @author Cody Sandahl
	 */
	public class IndoorHouseLevel extends TopDownLevel
	{
		/**
		 * Floor layer
		 */
		protected static var FLOORS:Array = new Array(
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		);
		
		/**
		 * Wall layer
		 */
		protected static var WALLS:Array = new Array(
			1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8,
			2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
		);
		
		/**
		 * Custom groups
		 */
		protected var decalGroup:FlxGroup; // extra decorative elements (no collisions)
		protected var objectGroup:FlxGroup; // objects and obstacles (with collisions)
		protected var glitchGroup:FlxGroup; // distortions in the internet, which on collision will start a battle
		
		/**
		 * Game objects
		 */
		protected var bookcase:FlxSprite;
		protected var armor:FlxSprite;
		protected var table:FlxSprite;
		protected var bed:FlxSprite;
		
		protected var depthMap:FlxDepthMap;
		
		
		/**
		 * Constructor
		 * @param	state		State displaying the level
		 * @param	levelSize	Width and height of level (in pixels)
		 * @param	blockSize	Default width and height of each tile (in pixels)
		 */
		public function IndoorHouseLevel(state:FlxState, levelSize:FlxPoint, blockSize:FlxPoint):void {
			super(state, levelSize, blockSize);
			depthMap = new FlxDepthMap(Assets.MARKET_DEPTHMAP);
			depthMap.z = 0;
			this.add(depthMap);
		}
		
		/**
		 * Create the map (walls, decals, etc)
		 */
		override protected function createMap():void {
			/*
			var tiles:FlxTilemap;
			// floors
			tiles = new FlxTilemap();
			tiles.loadMap(
				FlxTilemap.arrayToCSV(FLOORS, 15), // convert our array of tile indices to a format flixel understands
				Assets.FLOORS_TILE, // image to use
				tileSize.x, // width of each tile (in pixels)
				tileSize.y, // height of each tile (in pixels)
				0, // don't use auto tiling (needed so we can change the rest of these values)
				0, // starting index for our tileset (0 = include everything in the image)
				0, // starting index for drawing our tileset (0 = every tile is drawn)
				uint.MAX_VALUE // which tiles allow collisions by default (uint.MAX_VALUE = no collisions)
			);
			tiles.z = 0;
			tiles.debug_id = "floor";
			floorGroup.add(tiles);
			// walls
			// FFV: make left/right walls' use custom collision rects
			tiles = new FlxTilemap();
			tiles.loadMap(
				FlxTilemap.arrayToCSV(WALLS, 15), // convert our array of tile indices to a format flixel understands
				Assets.WALLS_TILE, // image to use
				tileSize.x, // width of each tile (in pixels)
				tileSize.y // height of each tile (in pixels)
			);
			tiles.z = 1;
			tiles.debug_id = "walls";
			wallGroup.add(tiles);
			// objects
			createObjects();
			*/
			var background:FlxSprite;
			background = new FlxSprite(0, 0, Assets.MARKET_5);
			background.z = 1;
			background.immovable = true;
			background.solid = false;
			//floorGroup.add(background);
			background = new FlxSprite(545, 535, Assets.MARKET_4);
			background.z = 2;
			background.immovable = true;
			background.solid = false;
			floorGroup.add(background);
			background = new FlxSprite(698, 365, Assets.MARKET_3);
			background.z = 3;
			background.immovable = true;
			background.solid = false;
			floorGroup.add(background);
			background = new FlxSprite(0, 0, Assets.MARKET_2);
			background.z = 4;
			background.immovable = true;
			background.solid = false;
			floorGroup.add(background);
			background = new FlxSprite(0, 884, Assets.MARKET_1);
			background.z = 5;
			background.immovable = true;
			background.solid = false;
			floorGroup.add(background);
		}
		
		/**
		 * Add all the objects, obstacles, etc to the level
		 */
		protected function createObjects():void {
			var sprite:FlxSprite;
			// create custom groups
			decalGroup = new FlxGroup();
			objectGroup = new FlxGroup();
			glitchGroup = new FlxGroup();
			// decals (decorative elements that have no functionality)
			sprite = new FlxSprite(
				16, // x location
				16, // y location
				Assets.RUG1_SPRITE // image to use
			);
			sprite.solid = false;
			sprite.immovable = true;
			sprite.z = 2;
			sprite.debug_id = "rug1";
			decalGroup.add(sprite);
			
			sprite = new FlxSprite(
				11 * tileSize.x, // x location (using tileSize to align it with a tile)
				1.5 * tileSize.y, // y location (showing that you don't need to line up with a tile)
				Assets.RUG2_SPRITE // image to use
			);
			sprite.solid = false;
			sprite.immovable = true;
			sprite.z = 2;
			sprite.debug_id = "rug2";
			decalGroup.add(sprite);
			// objects and obstacles
			// NOTE: this group gets tested for collisions
			bookcase = new FlxSprite(
				32, // x location
				0, // y location (showing that you can overlap with the walls if you want)
				Assets.BOOKCASE_SPRITE // image to use
			);
			bookcase.immovable = true; // don't allow the player to move this object
			bookcase.z = 2;
			bookcase.debug_id = "bookcase";
			objectGroup.add(bookcase);
			
			table = new FlxSprite(192, 192, Assets.TABLEROUND_SPRITE);
			table.immovable = true;
			table.z = 3;
			table.debug_id = "table";
			objectGroup.add(table);
			
			sprite = new FlxSprite(176, 192, Assets.CHAIRRIGHT_SPRITE);
			sprite.immovable = true;
			sprite.z = 3;
			sprite.debug_id = "chair_right";
			objectGroup.add(sprite);
			
			sprite = new FlxSprite(216, 192, Assets.CHAIRLEFT_SPRITE);
			sprite.immovable = true;
			sprite.z = 3;
			sprite.debug_id = "chair_left";
			objectGroup.add(sprite);
			
			armor = new FlxSprite(192, 0, Assets.ARMOR_SPRITE);
			armor.immovable = true;
			sprite.z = 3;
			sprite.debug_id = "armor";
			objectGroup.add(armor);
			
			bed = new FlxSprite(16, 192, Assets.BED_SPRITE);
			bed.immovable = true;
			bed.z = 3;
			sprite.debug_id = "bed";
			objectGroup.add(bed);
		}
		
		protected function createGlitches():void {
			if (TempSaveData.glitchesLeft.length > 0)
			{
				for (var i:uint = 0; i < TempSaveData.glitchesLeft.length; i++)
				{
					glitchGroup.add(TempSaveData.glitchesLeft[i]);
				}
			}
			else
			{
				var glitchA:FlxSprite = new FlxSprite(25, 50, Assets.ARMOR_SPRITE);
				glitchA.immovable = true;
				glitchGroup.add(glitchA);
				TempSaveData.glitchesLeft.push(glitchA);
				
				var glitchB:FlxSprite = new FlxSprite(123, 75, Assets.ARMOR_SPRITE);
				glitchB.immovable = true;
				glitchGroup.add(glitchB);
				TempSaveData.glitchesLeft.push(glitchB);
				
				var glitchC:FlxSprite = new FlxSprite(90, 145, Assets.ARMOR_SPRITE);
				glitchC.immovable = true;
				glitchGroup.add(glitchC);
				TempSaveData.glitchesLeft.push(glitchC);
			}
		}
		
		override protected function createNPCs():void {
			var homeOwner:NPC = new NPC(40, 76, Assets.NPC_SPRITE, Assets.TEST_NPC_DIALOG_1, "TEST_NPC_DIALOG_1", add, remove);
			homeOwner.solid = true;
			homeOwner.immovable = true;
			homeOwner.z = 4;
			homeOwner.debug_id = "npc";
			//this.npcGroup.add(homeOwner);
		}
		
		/**
		 * Create the player
		 */
		override protected function createPlayer():void {
			player = new Player(playerStart.x, playerStart.y, 54, 144);
			player.debug_id = "player";
			player.z = 6;
		}
		
		/**
		 * Create text, buttons, indicators, etc
		 */
		override protected function createGUI():void {
			/*
			var instructions:FlxText = new FlxText(0, 0, levelSize.x, "Use ARROW keys to walk around");
			instructions.alignment = "center";
			guiGroup.add(instructions);
			*/
			guiGroup.debug_id = "gui";
			guiGroup.z = 6;
		}
		
		/**
		 * Decide the order of the groups. They are rendered in the order they're added, so last added is always on top.
		 */
		override protected function addGroups():void {
			for (var i:uint = 0; i < floorGroup.members.length; i++ ) {
				this.add(floorGroup.members[i]);
			}
			/*
			for (var j:uint = 0; j < wallGroup.members.length; j++ ) {
				this.add(wallGroup.members[j]);
			}
			for (var k:uint = 0; k < decalGroup.members.length; k++ ) {
				this.add(decalGroup.members[k]);
			}
			for (var m:uint = 0; m < objectGroup.members.length; m++ ) {
				this.add(objectGroup.members[m]);
			}
			*/
			for (var n:uint = 0; n < npcGroup.members.length; n++ ) {
				this.add(npcGroup.members[n]);
			}
			this.add(player);
			this.add(guiGroup);
		}
		
		/**
		 * Update each timestep
		 */
		override public function update():void {
			super.update(); // NOTE: map -> player collision happens in super.update()
			FlxG.collide(objectGroup, player);
			FlxG.collide(npcGroup, player);
			
			depthMap.setDepth(player);
			depthMap.collide(player);
			
			// If the player has chosen to interact, see
			// if there is anything to interact with.
			if (FlxG.keys.justPressed(FlxControls.ACTION_2))
			{
				for (var i:uint = 0; i < objectGroup.members.length; i++)
				{
					if ((objectGroup.members[i] is GenericInteractiveObject) && objectGroup.members[i].pixelsOverlapPoint(player.speakingRange))
					{
						objectGroup.members[i].showDialog();
					}
				}
				for (var j:uint = 0; j < npcGroup.members.length; j++)
				{
					if ((npcGroup.members[j] is NPC) && npcGroup.members[j].pixelsOverlapPoint(player.speakingRange))
					{
						npcGroup.members[j].showDialog();
					}
				}
			}
			
			/*
			for (var k:uint = 0; k < glitchGroup.members.length; k++)
			{
				if (FlxG.collide(glitchGroup.members[k], player))
				{
					TempSaveData.lastPlayerPosition.x = player.x;
					TempSaveData.lastPlayerPosition.y = player.y;
					TempSaveData.glitchesLeft[k] = null; // remove the reference
					glitchGroup.members[k].destroy(); // remove the glitch
					
					FlxG.switchState(new BattleState(this));
				}
			}
			*/
			this.sort("z"); // z sort all objects
		}
	}
}
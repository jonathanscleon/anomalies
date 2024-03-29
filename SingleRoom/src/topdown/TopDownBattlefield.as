package topdown 
{
	import org.flixel.*;
	
	/**
	 * Base class for all levels
	 * @author Cody Sandahl
	 */
	public class TopDownBattlefield extends FlxGroup
	{
		/**
		 * Map
		 */
		public var state:FlxState; // state displaying the level
		public var levelSize:FlxPoint; // width and height of level (in pixels)
		public var tileSize:FlxPoint; // default width and height of each tile (in pixels)
		public var numTiles:FlxPoint; // how many tiles are in this level (width and height)
		public var floorGroup:FlxGroup; // floor (rendered beneath the walls - no collisions)
		public var wallGroup:FlxGroup; // all the map blocks (with collisions)
		public var enemyGroup:FlxGroup; // all the enemies
		public var allyGroup:FlxGroup; // all the allies
		public var guiGroup:FlxGroup; // gui elements
		
		/**
		 * Player
		 */
		//public var player:Player;
		//public var playerStart:FlxPoint = new FlxPoint(120, 120);
		
		/**
		 * Constructor
		 * @param	state		State displaying the level
		 * @param	levelSize	Width and height of level (in pixels)
		 * @param	blockSize	Default width and height of each tile (in pixels)
		 */
		public function TopDownBattlefield(state:FlxState, levelSize:FlxPoint, tileSize:FlxPoint):void 
		{
			super();
			this.state = state;
			this.levelSize = levelSize;
			this.tileSize = tileSize;
			if (levelSize && tileSize)
				this.numTiles = new FlxPoint(Math.floor(levelSize.x / tileSize.x), Math.floor(levelSize.y / tileSize.y));
			// setup groups
			this.floorGroup = new FlxGroup();
			this.wallGroup = new FlxGroup();
			this.enemyGroup = new FlxGroup();
			this.allyGroup = new FlxGroup();
			this.guiGroup = new FlxGroup();
			// create the level
			this.create();
		}
		
		/**
		 * Create the whole level, including all sprites, maps, blocks, etc
		 */
		public function create():void 
		{
			createMap();
			createEnemies();
			createAllies();
			createGUI();
			addGroups();
			createCamera();
		}
		
		/**
		 * Create the map (walls, decals, etc)
		 */
		protected function createMap():void 
		{
		}
		
		protected function createEnemies():void 
		{
		}
		
		protected function createAllies():void 
		{
			
		}
		
		/**
		 * Create text, buttons, indicators, etc
		 */
		protected function createGUI():void 
		{
		}
		
		/**
		 * Decide the order of the groups. They are rendered in the order they're added, so last added is always on top.
		 */
		protected function addGroups():void 
		{
			this.add(floorGroup);
			this.add(wallGroup);
			this.add(enemyGroup);
			this.add(allyGroup);
			//this.add(player);
			this.add(guiGroup);
		}
		
		/**
		 * Create the default camera for this level
		 */
		protected function createCamera():void 
		{
			FlxG.worldBounds = new FlxRect(0, 0, levelSize.x, levelSize.y);
			FlxG.camera.setBounds(0, 0, levelSize.x, levelSize.y, true);
			//FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN);
		}
		
		/**
		 * Update each timestep
		 */
		override public function update():void 
		{
			super.update();
			//FlxG.collide(wallGroup, player);
		}
	}
}

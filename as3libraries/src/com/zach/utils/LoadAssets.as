package com.zach.utils
{
	import com.zach.events.CustomEvent;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.display.MovieClip;
	
	public class LoadAssets extends EventDispatcher
	{
		public static const MOVIECLIP:String = "movieclip";
		public static const DISPLAY_OBJECT:String = "displayobject";
		
		private var loader:Loader;
		private var type:String = MOVIECLIP;
		private var classes:Array;
		private var batch:Boolean = false;
		private var assets:Array;
		
		public static const ON_ASSET_LOADED:String = "onAssetLoaded";
		
		public function LoadAssets():void
		{
			loader = new Loader();
			assets = new Array();
			loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaded);
		}
		
		private function onLoaded(e:Event):void
		{
			var tempObject:Object = new Object();
			var d_o:Class;
			
			if ( type == DISPLAY_OBJECT )
			{
				if ( classes != null )
				{
					for ( var i:uint = 0; i < classes.length; i++ )
					{
						d_o = loader.contentLoaderInfo.applicationDomain.getDefinition(classes[i]) as Class;
						assets.push(d_o);
					}
				}
				
				tempObject.assets = assets;
			}
			
			dispatchEvent(new CustomEvent(ON_ASSET_LOADED, tempObject)); 
		}
		
		public function load(pAsset:String, pType:String = MOVIECLIP, pClass:Array = null):void
		{
			type = pType;
			classes = pClass;
			loader.load(new URLRequest(pAsset));
		}
	}

}
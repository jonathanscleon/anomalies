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
	
	public class LoadAsset extends EventDispatcher
	{
		public static const MOVIECLIP:String = "movieclip";
		public static const DISPLAY_OBJECT:String = "displayobject";
		
		private var loader:Loader;
		private var type:String = MOVIECLIP;
		private var classType:String = "";
		
		public static const ON_ASSET_LOADED:String = "onAssetLoaded";
		
		public function LoadAsset():void
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaded);
		}
		
		private function onLoaded(e:Event):void
		{
			var tempObject:Object = new Object();
			var mc:DisplayObject;
			var d_o:Class;
			
			if ( type == MOVIECLIP )
			{
				mc = e.currentTarget.content as DisplayObject;
				tempObject.asset = mc;
			}
			else if ( type == DISPLAY_OBJECT )
			{
				d_o = loader.contentLoaderInfo.applicationDomain.getDefinition(classType) as Class;
				mc = e.currentTarget.content as MovieClip;
				tempObject.asset = d_o;
				tempObject.mc = mc;
			}
			
			dispatchEvent(new CustomEvent(ON_ASSET_LOADED, tempObject)); 
		}
		
		public function load(pAsset:String, pType:String = MOVIECLIP, pClass:String = null):void
		{
			type = pType;
			classType = pClass;
			loader.load(new URLRequest(pAsset));
		}
	}

}
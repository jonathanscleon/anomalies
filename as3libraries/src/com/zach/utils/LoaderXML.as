package com.zach.utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.ProgressEvent;
	import flash.events.HTTPStatusEvent;
	
	import com.zach.events.CustomEvent;
	
	public class LoaderXML extends EventDispatcher
	{
		private var loader:URLLoader;
		private var xmlData:XML;
		
		public static const LOADER_XML_LOADED:String = "loaderXMLLoaded";
		public static const LOADER_XML_ERROR:String = "loaderXMLError";
		public static const LOADER_XML_PROGRESS:String = "loaderXMLProgress";
		public static const LOADER_XML_OPEN:String = "loaderXMLOpen";
		
		public function LoaderXML()
		{
			loader = new URLLoader();
		}
		
		public function destroy(everything:Boolean):void
		{
			xmlData = null;
			if ( everything )
			{
				loader = null;
			}
		}
		
		public function load(xmlDataSource:String):void
		{
			//(Matt Kaemmerer, 6/17/2011) Changed from weak references to strong references to fix XML loading bug:
			loader.addEventListener(Event.COMPLETE, onXMLLoadedComplete, false, 0, false);
			
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError, false, 0, true);
			loader.addEventListener(ProgressEvent.PROGRESS, onProgressEvent, false, 0, true);
			loader.addEventListener(Event.OPEN, onOpenEvent, false, 0, true);
			
			loader.load(new URLRequest(xmlDataSource));
			
			var tempXMLObject:Object = new Object();
			
			function onXMLLoadedComplete(evt:Event):void
			{
				//trace("onXMLLoadedComplete\n" + evt);
				try {
					xmlData = new XML(evt.target.data);
					loader.removeEventListener(Event.COMPLETE, onXMLLoadedComplete);
					loader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
					loader.removeEventListener(ProgressEvent.PROGRESS, onProgressEvent);
					loader.removeEventListener(Event.OPEN, onOpenEvent);
					
					tempXMLObject.xml = xmlData;
					dispatchEvent(new CustomEvent(LOADER_XML_LOADED, tempXMLObject));
				} catch (err:Error) {
					trace(err.message);
					tempXMLObject.error = err.message;
					dispatchEvent(new CustomEvent(LOADER_XML_ERROR, tempXMLObject));
				}
			}
			
			function onProgressEvent(evt:ProgressEvent):void
			{
				tempXMLObject.progress = evt;
				dispatchEvent(new CustomEvent(LOADER_XML_PROGRESS, tempXMLObject));
			}
			
			function onOpenEvent(evt:Event):void
			{
				tempXMLObject.open = evt;
				dispatchEvent(new CustomEvent(LOADER_XML_OPEN, tempXMLObject));
			}
			
			function onIOError(evt:IOErrorEvent):void
			{
				tempXMLObject.error = evt.text;
				dispatchEvent(new CustomEvent(LOADER_XML_ERROR, tempXMLObject));
			}
		}
	}
}
		
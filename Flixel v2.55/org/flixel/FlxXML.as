package org.flixel
{
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	/**
	 * A simple class that loads an XML file.
	 * @author Redkast Games
	 */
	public class FlxXML
	{
		private var loader:URLLoader;
		/**
		 * Create the loader
		 */
		public function FlxXML() { }
		/**
		 * Load the XML file from an external server.
		 * @param	url			The url of the XML file (e.g. http://www.somesite.com/main.xml);
		 * @param	onComplete	The function to execute once the load is complete( function c(data:XML):void );
		 * @param	onProgress	The optional function to use on progress (function p( loaded:int, total:int):void);
		 */
		public function loadExternal(url:String, onComplete:Function, onProgress:Function = null):void
		{
			loader = new URLLoader(new URLRequest(url));
			loader.addEventListener(Event.COMPLETE, function complete(e:Event):void
			{
				onComplete(XML(e.target.data));
			});
			loader.addEventListener(IOErrorEvent.IO_ERROR, function ioerror(e:IOErrorEvent):void
			{
				throw new Error("The specified XML file could not be found, load aborted");
			});
			if (onProgress != null) {
				loader.addEventListener(ProgressEvent.PROGRESS, function progress(e:ProgressEvent):void
				{
					onProgress(e.bytesLoaded, e.bytesTotal);
				});
			}
		}
		/**
		 * Convert an embeded file to XML
		 * @param	xml			The embedded XML file.
		 * @param	callback	Optional callback function (function c(data:XML):void);
		 * @return	The class as XML;
		 */
		public function loadEmbedded(xml:Class, callback:Function = null):XML
		{
			var b:ByteArray = new xml;
			var x:XML = XML(b.readUTFBytes(b.length));
			if (callback != null) callback(x);
			return x;
		}
	}
	
}
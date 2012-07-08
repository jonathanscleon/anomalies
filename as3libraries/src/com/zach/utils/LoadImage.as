package com.zach.utils 
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import org.osflash.signals.Signal;
	
	/**
	 * This class loads an image
	 * 
	 */
	public class LoadImage 
	{
		// The loader that will contain the loaded image
		private var _imageLoader:Loader;
		
		// Lets the caller know when the image has been loaded
		public var _imageLoaded:Signal;
		
		// Prevents more than one call to load at a time
		private var _loading:Boolean;
		
		private var _url:String;
		
		/**
		 * Constructor
		 */
		public function LoadImage() 
		{
			_imageLoaded = new Signal();
			_loading = false;
		}
		
		/**
		 * Loads an image given its location
		 * @param	url	The location of the image
		 */
		public function load(url:String):void
		{
			if (!_loading)
			{
				_url = url;
				_imageLoader = new Loader();
				_imageLoader.load(new URLRequest(url));
				_imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
				_imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
				
				_loading = true;
			}
		}
		
		private function errorHandler(err:IOErrorEvent):void
		{
			trace("Could not open file: " + err.currentTarget.url + ", or possibly " + _url);
			_imageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		}
		
		/**
		 * Lets the caller know that the image has loaded,
		 * and prepares itself to have another image loaded.
		 * @param	e
		 */
		private function imageLoaded(e:Event):void
		{
			_loading = false;
			_imageLoaded.dispatch();
		}
		
		/**
		 * Returns the loaded image, but only if
		 * the image has finished loading.
		 * @return	Returns the loaded image
		 */
		public function getImage():DisplayObject
		{
			if(!_loading)
				return _imageLoader;
			else
				return null;
		}
	}

}
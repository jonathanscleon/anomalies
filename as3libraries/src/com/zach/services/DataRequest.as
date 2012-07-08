package com.zach.services 
{
	import com.adobe.serialization.json.JSON;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import org.osflash.signals.Signal;
	
	/**
	 * This class requests data from the database
	 * 
	 */
	public class DataRequest 
	{
		
		// @TODO: read actual host from flashvars
		private static var _baseURL:String = "http://localhost/";
		
		// Signals when the data has been returned from the dataabse
		public static var submitComplete:Signal = new Signal();
		
		// Lets the user know when there has been an error
		public static var error:Signal = new Signal();
		
		/**
		 * Constructor
		 */
		public function DataRequest() 
		{
			
		}
		
		/**
		 * Submits a get to the php framework.
		 * @param	controller	The controller to call
		 * @param	view		The view to access
		 */
		public static function submitGet(controller:Array, view:Array):void
		{
			var url:String = _baseURL + "/" + controller.join("/") + "/" + view.join("/");
			var request:URLRequest = new URLRequest(url);
			
			loadRequest(request);
		}
		
		/**
		 * Submits a post to the php framework.
		 * @param	controller	The controller to call
		 * @param	view		The view to access
		 * @param	vars		The data to pass to the php framework
		 */
		public static function submitPost(controller:Array, view:Array, vars:Object):void
		{
			var url:String = _baseURL + "/" + controller.join("/") + "/" + view.join("/");
			
			var request:URLRequest = new URLRequest(url);
			request.method = URLRequestMethod.POST;
			request.data = new URLVariables();
			
			for (var varName:String in vars)
			{
				request.data[varName] = vars[varName];
			}
			
			loadRequest(request);
		}
		
		/**
		 * Sends the request to the database, and signals the caller
		 * when the request is complete
		 * @param	request	The database request
		 */
		private static function loadRequest(request:URLRequest):void
		{
			try
			{
				var loader:URLLoader = new URLLoader(request);
			}
			catch (e:IOError)
			{
				trace(e.message);
			}
			
			loader.addEventListener(Event.COMPLETE, onComplete);
			
			function onComplete(e:Event):void
			{
				loader.removeEventListener(Event.COMPLETE, onComplete);
				submitComplete.dispatch(parseResponse(e.target.data));
			}
		}
		
		/**
		 * Sets the url for the host
		 * @param	value	The host url
		 */
		public static function set baseURL(value:String):void
		{
			_baseURL = value;
		}
		
		/**
		 * Takes the json string from the database and decodes it
		 * for use in flash
		 * @param	response	Database info in json format
		 * @return	Returns the database info as an array of key, value pairs
		 */
		private static function parseResponse(response:String):Array
		{
			if (!response) return null;
			
			try
			{
				var object:Object = JSON.decode(response);
				return object as Array || [object];
			}
			catch (e:Error) 
			{ 
				
			}
			
			error.dispatch(["Error decoding JSON:" + response]);
			return null;
		}
	}

}
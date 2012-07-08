package com.zach.events
{
	import flash.events.Event;
	
	public class CustomEvent extends Event
	{
		protected var _data:Object;
		
		public function CustomEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			_data = data;
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new CustomEvent(type, data, bubbles, cancelable);
		}
		
		public function get data():Object
		{
			return _data;
		}
	}
}
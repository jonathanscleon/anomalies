package com.zach.datastructures
{
	
	/**
	 * This class is a generic hash map class.
	 * 
	 */
	public dynamic class HashMap extends Object
	{
		/**
		 * The size of the hash map.
		 */
		protected var _size:int;
		
		/**
		 * Returns the number of entries.
		 */
		public function get size():int
		{
			return _size;
		}
		
		/**
		 * Tells the user whether or not the hash map is empty.
		 * @return	Returns whether or not the hash map is empty.
		 */
		public function isEmpty():Boolean
		{
			return _size == 0;
		}
		
		/**
		 * If the hash map contains an entry with key equal t ok,
		 * then return the value of the corresponding object.
		 * Else, return null.
		 * @param	k	Key
		 * @return	Returns the value, or null
		 */
		public function getItem(k:String):Object
		{
			return this[k];
		}
		
		/**
		 * If the hash map does not have an entry with key equal to k,
		 * then add entry (k,v) to it and return true. Else, 
		 * ignore it and return false.
		 * @param	k	Key
		 * @param	v	Value
		 * @return	Returns whether or not the object was inserted.
		 */
		public function insert(k:String, v:Object):Boolean
		{
			// already have one
			if (this[k] != null)
				return false;
			
			this[k] = v;
			_size++;
			
			return true;
		}
		
		/**
		 * Remove the entry with key equal to k.
		 * @param	k
		 */
		public function remove(k:String):void
		{
			if (this[k] != null)
			{
				_size--;
				this[k] = null;
			}
		}
		
		/**
		 * Remove the entry with key equal to k and return
		 * its value. If the hash map has no such entry,
		 * return null.
		 * @param	k
		 * @return	Returns the object that was just removed.
		 */
		public function pop(k:String):Object
		{
			if (this[k] != null)
			{
				var result:Object = this[k];
				
				_size--;
				delete this[k];
				
				return result;
			}
			else
				return null;
		}
		
		/**
		 * Removes all elements from the hash map.
		 */
		public function clear():void
		{
			for (var k:String in this)
				this[k] = null;
			_size = 0;
		}
		
		/**
		 * Gets all the items in the hash map and 
		 * returns them as an array.
		 */
		public function getAll():Array
		{
			var a:Array = new Array();
			
			for (var k:String in this)
				a.push(this[k]);
				
			return a;
		}
	}

}
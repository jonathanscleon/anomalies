package org.flixel.dialog {
	
	
	import org.flixel.*;
	
	
	public class FlxDialog extends FlxGroup{
		
		/**
		 * Use this to allow locking of controls when the dialog is displaying.
		 */
		public static var LOCK_MOVEMENT:Boolean = false;
		
		/**
		 * Use this to tell if dialog is showing on the screen or not.
		 */
		public var showing:Boolean;
		
		/**
		 * The text field used to display the text
		 */
		protected var _field:FlxText;
		
		/**
		 * Called when current page in dialog is finished (optional)
		 */
		protected var _endPageCallback:Function;
		
		/**
		 * Called when dialog is finished (optional)
		 */
		protected var _finishCallback:Function;

		protected var _dialog:FlxConversation;
		protected var _currentDialog:FlxDialogPiece;
		
		/**
		 * Background rect for the text
		 */
		protected var _bg:FlxSprite;
		
		protected var _width:Number;
		protected var _height:Number;
		protected var _backgroundColor:uint;
		
		internal var _charIndex:int;
		internal var _displaying:Boolean;
		internal var _displaySpeed:Number;
		internal var _elapsed:Number;
		internal var _endPage:Boolean;
		
		public function FlxDialog(X:Number=0, Y:Number=0, Width:Number=310, Height:Number=72, displaySpeed:Number=.45, background:Boolean=true, backgroundColor:uint=0x77000000)
		{				
			_width 	= Width;
			_height	= Height;
			_backgroundColor = backgroundColor;
			
			_bg = new FlxSprite().makeGraphic(_width, _height, _backgroundColor);
			_bg.scrollFactor.x = _bg.scrollFactor.y = 0;
			_bg.x = X;
			_bg.y = Y;
			
			if(background){
				add(_bg);
			}
			
			_field = new FlxText(0, 0, _width, "");
			_field.scrollFactor.x = _field.scrollFactor.y = 0;
			add(_field);
			
			_elapsed = 0;
			
			_displaySpeed = displaySpeed;
			_bg.alpha = 0;
		}
		
		/**
		 * Call this to set the format of the text
		 */
		public function setFormat(font:String=null, Size:Number=8, Color:uint=0xffffff, Alignment:String=null, ShadowColor:uint=0):void
		{
			_field.setFormat(font, Size, Color, Alignment, ShadowColor);
		}
		
		/**
		 * Call this from your code to display some dialog
		 */
		public function showDialog(dialog:FlxConversation):void
		{
			_dialog = dialog;
			_currentDialog = _dialog.getCurrentStatement();
			_charIndex = 0;
			_field.text = _currentDialog.text.charAt(0);
			_displaying = true;
			_bg.alpha = 1;
			showing = true;
			LOCK_MOVEMENT = true;
		}
		
		/**
		 * The meat of the class. Used to display text over time as well
		 * as control which page is 'active'
		 */
		override public function update():void
		{			
			if(_displaying)
			{
				_elapsed += FlxG.elapsed;
				
				if(_elapsed > _displaySpeed)
				{
					_elapsed = 0;
					_charIndex++;
					if(_charIndex > _currentDialog.text.length)
					{
						if(_endPageCallback!=null) _endPageCallback();
						_endPage = true;
						_displaying = false;
					}
					
					_field.text = _currentDialog.text.substr(0, _charIndex);
				}
			}
			
			if(FlxG.keys.justPressed(FlxControls.ACTION_2))
			{
				if(_displaying)
				{
					_displaying = false;
					_endPage = true;
					_field.text = _currentDialog.text;
					_elapsed = 0;
					_charIndex = 0;
				}
				else if(_endPage)
				{
					_currentDialog = _dialog.getNextStatement();
					if(_currentDialog == null)
					{
						//we're at the end of the pages
						_field.text = "";
						_bg.alpha = 0;
						if(_finishCallback!=null) _finishCallback();
						showing = false;
						LOCK_MOVEMENT = false;
					}
					else
					{
						_displaying = true;
					}
				}
			}
			
			super.update();
		}
		
		/**
		 * Called when the current page in dialog is completely finished
		 */
		public function set endPageCallback(val:Function):void
		{
			_endPageCallback = val;
		}
		
		/**
		 * Called when the dialog is completely finished
		 */
		public function set finishCallback(val:Function):void
		{
			_finishCallback = val;
		}
		
	}
}
package org.flixel.dialog 
{
	import org.flixel.*;
	
	/**
	 * An extension of the FlxDialog class, which gives the
	 * ability to select dialog options.
	 * @author Jonathan Collins Leon
	 */
	public class FlxDialogWithOptions extends FlxDialog
	{
		
		public function FlxDialogWithOptions(X:Number=0, Y:Number=0, Width:Number=310, Height:Number=72, displaySpeed:Number=.45, background:Boolean=true, backgroundColor:uint=0x77000000) 
		{
			super(X, Y, Width, Height, displaySpeed, background, backgroundColor);
		}
		
		/*
		override public function showDialog(pages:Array):void
		{
			_pageIndex = 0;
			_charIndex = 0;
			_field.text = pages[0].charAt(0);
			_dialogArray = pages;
			_displaying = true;
			_bg.alpha = 1;
			showing = true;
			LOCK_MOVEMENT = true;
		}
		*/
		
		/**
		 * The meat of the class. Used to display text over time as well
		 * as control which page is 'active'
		 */
		/*
		override public function update():void
		{			
			if(_displaying)
			{
				_elapsed += FlxG.elapsed;
				
				if(_elapsed > _displaySpeed)
				{
					_elapsed = 0;
					_charIndex++;
					if(_charIndex > _dialogArray[_pageIndex].length)
					{
						if(_endPageCallback!=null) _endPageCallback();
						_endPage = true;
						_displaying = false;
					}
					
					_field.text = _dialogArray[_pageIndex].substr(0, _charIndex);
				}
			}
			
			if(FlxG.keys.justPressed(FlxControls.ACTION_2))
			{
				if(_displaying)
				{
					_displaying = false;
					_endPage = true;
					_field.text = _dialogArray[_pageIndex];
					_elapsed = 0;
					_charIndex = 0;
				}
				else if(_endPage)
				{
					if(_pageIndex == _dialogArray.length - 1)
					{
						//we're at the end of the pages
						_pageIndex = 0;
						_field.text = "";
						_bg.alpha = 0;
						if(_finishCallback!=null) _finishCallback();
						showing = false;
						LOCK_MOVEMENT = false;
					}
					else
					{
						_pageIndex++;
						_displaying = true;
					}
				}
			}
			
			super.update();
		}
		*/
	}

}
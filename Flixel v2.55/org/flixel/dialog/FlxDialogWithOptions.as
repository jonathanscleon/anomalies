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
		protected var _optionX:Number;
		protected var _optionY:Number;
		protected var _optionWidth:Number;
		protected var _optionFields:Array; // array of FlxText
		protected var _optionBackgrounds:Array;
		protected var _optionBG:FlxSprite;
		protected var _optionHighlightColor:uint;
		protected var _currentlySelectedOption:uint;
		protected var _optionsDisplaying:Boolean;
		
		public function FlxDialogWithOptions(X:Number=0, Y:Number=0, Width:Number=310, Height:Number=72, displaySpeed:Number=.15, background:Boolean=true, backgroundColor:uint=0x77000000, optionX:Number=0, optionY:Number=0, optionWidth:Number=155, optionHighlightColor:uint=0xcc000000) 
		{
			super(X, Y, Width, Height, displaySpeed, background, backgroundColor);
			_optionX = optionX;
			_optionY = optionY;
			_optionWidth = optionWidth;
			_optionHighlightColor = optionHighlightColor;
			_optionFields = new Array();
			_optionBackgrounds = new Array();
		}
		
		public function getCurrentDialog():FlxConversation
		{
			return _dialog;
		}
		
		protected function displayOptions():void
		{
			if(_currentDialog.options.length == 0)
				return;
			
			var optionFieldsHeight:Number = _bg.height + 5;
			for each(var option:FlxDialogOption in _currentDialog.options)
			{
				var optionField:FlxText = new FlxText(0, optionFieldsHeight, _optionWidth, option.text);
				optionField.scrollFactor.x = optionField.scrollFactor.y = 0;
				_optionFields.push(optionField);
				
				var optionFieldHighlight:FlxSprite = new FlxSprite().makeGraphic(_optionWidth, optionField.height, _optionHighlightColor);
				optionFieldHighlight.scrollFactor.x = optionFieldHighlight.scrollFactor.y = 0;
				optionFieldHighlight.x = 0;
				optionFieldHighlight.y = optionFieldsHeight;
				optionFieldHighlight.visible = false;
				_optionBackgrounds.push(optionFieldHighlight);
				
				optionFieldsHeight += optionField.height;
			}
			
			_optionBG = new FlxSprite().makeGraphic(_optionWidth, optionFieldsHeight, _backgroundColor);
			_optionBG.scrollFactor.x = _optionBG.scrollFactor.y = 0;
			_optionBG.x = _optionX;
			_optionBG.y = _optionY;

			add(_optionBG);
			
			_optionBG.alpha = 0;
			
			for (var i:uint = 0; i < _optionFields.length; i++)
			{
				add(_optionBackgrounds[i]);
				add(_optionFields[i]);
			}
			
			_currentlySelectedOption = 0;
			_optionsDisplaying = true;
			_optionBackgrounds[0].visible = true;
		}
		
		protected function hideOptions():void
		{
			if (_optionFields.length == 0)
				return;
			
			for (var i:uint = 0; i < _optionFields.length; i++)
			{
				remove(_optionBackgrounds[i]);
				remove(_optionFields[i]);
				
				_optionBackgrounds[i].destroy();
				_optionFields[i].destroy();
			}
			
			_optionBackgrounds = new Array();
			_optionFields = new Array();
		}
		
		protected function updateSelectedOption(direction:String):void
		{
			_optionBackgrounds[_currentlySelectedOption].visible = false;
			
			// selections loop around
			if(direction == FlxControls.DOWN)
			{
				_currentlySelectedOption = (_currentlySelectedOption + 1) % _optionFields.length;
			}
			else if(direction == FlxControls.UP)
			{
				if(_currentlySelectedOption == 0)
					_currentlySelectedOption = _optionFields.length - 1;
				else
					_currentlySelectedOption = (_currentlySelectedOption - 1) % _optionFields.length;
			}
			
			_optionBackgrounds[_currentlySelectedOption].visible = true;
		}
		
		/**
		 * The meat of the class. Used to display text over time as well
		 * as control which page is 'active'
		 */
		override public function update():void
		{
			super.update();
		}
		
		override protected function updateHelper():void
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
						displayOptions();
					}
		
					_field.text = _currentDialog.text.substr(0, _charIndex);
				}
			}
			
			if (_optionsDisplaying)
			{
				if(FlxG.keys.justPressed(FlxControls.UP))
				{
					updateSelectedOption(FlxControls.UP);
				}
				else if(FlxG.keys.justPressed(FlxControls.DOWN))
				{
					updateSelectedOption(FlxControls.DOWN);
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
					displayOptions();
				}
				else if(_endPage)
				{
					if (_optionsDisplaying)
					{
						// call setVars of selected option somehow
						_currentDialog = _dialog.getNextStatement(_currentDialog.options[_currentlySelectedOption].goto);
					}
					else
						_currentDialog = _dialog.getNextStatement(_currentDialog.goto);
					
					if(_currentDialog == null)
					{
						//we're at the end of the pages
						_field.text = "";
						_bg.alpha = 0;
						if(_finishCallback!=null) _finishCallback();
						showing = false;
						LOCK_MOVEMENT = false;
						_justFinished = true;
						dialogFinished.dispatch(this);
					}
					else
					{
						_displaying = true;
						_optionsDisplaying = false;
					}
					
					hideOptions();
				}
			}
		}
	}

}
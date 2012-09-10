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
		/**
		 * Initial X location for an option
		 */
		protected var _optionX:Number;
		
		/**
		 * Initial Y location for an option
		 */
		protected var _optionY:Number;
		
		/**
		 * Option width
		 */
		protected var _optionWidth:Number;
		
		/**
		 * An array of FlxTexts which each contain a
		 * dialog option
		 */
		protected var _optionFields:Array;
		
		/**
		 * An array of FlxSprites used for dialog option backgrounds.
		 * Specifically, to distinguish highlighted options.
		 */
		protected var _optionBackgrounds:Array;
		
		/**
		 * FlxSprite for the background containing all
		 * the dialog options
		 */
		protected var _optionBG:FlxSprite;
		
		/**
		 * Color to be used for highlighted options
		 */
		protected var _optionHighlightColor:uint;
		
		/**
		 * Currently selected option
		 */
		protected var _currentlySelectedOption:uint;
		
		/**
		 * True if the options are currently being displayed
		 */
		protected var _optionsDisplaying:Boolean;
		
		/**
		 * Constructor
		 * @param	X						Initial X location for the dialog option display
		 * @param	Y						Initial Y location for the dialog option display
		 * @param	Width					Width of the dialog option display
		 * @param	Height					Height of the dialog option display
		 * @param	displaySpeed			The rate at which words will be revealed
		 * @param	background				Whether or not to use a background
		 * @param	backgroundColor			Which color to use for the background
		 * @param	optionX					Initial X location for the dialog options
		 * @param	optionY					Initial Y location for the dialog options
		 * @param	optionWidth				Width of a single dialog option
		 * @param	optionHighlightColor	Color for highlighted options
		 */
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
		
		/**
		 * Get the current dialog being displayed.
		 * @return	Returns the conversation object for the dialog currently being displayed.
		 */
		public function getCurrentDialog():FlxConversation
		{
			return _dialog;
		}
		
		/**
		 * Creates the display for the dialog options
		 */
		protected function displayOptions():void
		{
			// no dialog options to display
			if(_currentDialog.options.length == 0)
				return;
			
			// create display
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
			
			// create background
			_optionBG = new FlxSprite().makeGraphic(_optionWidth, optionFieldsHeight, _backgroundColor);
			_optionBG.scrollFactor.x = _optionBG.scrollFactor.y = 0;
			_optionBG.x = _optionX;
			_optionBG.y = _optionY;
			
			// display background
			add(_optionBG);
			
			_optionBG.alpha = 0;
			
			// display options
			for (var i:uint = 0; i < _optionFields.length; i++)
			{
				add(_optionBackgrounds[i]);
				add(_optionFields[i]);
			}
			
			_currentlySelectedOption = 0;
			_optionsDisplaying = true;
			_optionBackgrounds[0].visible = true;
		}
		
		/**
		 * Removes the dialog options from the display.
		 */
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
		
		/**
		 * Updates the selected option.
		 * @param	direction	Select either the previous or next option
		 */
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
		
		/**
		 * Class specific update
		 */
		override protected function updateHelper():void
		{
			// display the dialog at the defined rate
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
			
			// change the selected option, if
			// options are available
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
			
			// skip or end a part of the dialog
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
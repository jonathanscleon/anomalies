package com.zach.utils
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.utils.Timer;
	import org.osflash.signals.Signal;
	
	public class SoundController 
	{
		private var song:Sound;
		private var channel:SoundChannel;
		private var transform:SoundTransform;
		private var loop:int;
		private var _file:String = null;
				
		public static const LOOP_INDEFINITELY:int = -1;
		public static const STOPPED:uint = 100;
		public static const PLAYING:uint = 101;
		public static const PAUSED:uint = 102;
		
		private var _status:uint = STOPPED;
		private var _pausedTime:uint;
		private var timer:Timer;
		
		public var ready:Signal;
		public var songComplete:Signal;
		
		private var _loaded:Boolean = false;
		
		public function SoundController(pLoop:int = 0) 
		{
			loop = pLoop;
			song = new Sound();
			transform = new SoundTransform();
			ready = new Signal();
			songComplete = new Signal();
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, onTimerTick);
		}
		
		public function setVolume(pVolume:Number):void
		{
			transform.volume = pVolume;
			if ( channel != null )
			{
				channel.soundTransform = transform;
			}
		}
		
		private function onTimerTick(evt:TimerEvent):void
		{
			_pausedTime++;
		}
		
		private function soundCompleteHandler(evt:Event):void
		{
			songComplete.dispatch();
		}
		
		public function load(pSong:String = null):void
		{
			if ( _file != null )
			{
				pSong = _file;
			}
			
			if ( !_loaded )
			{
				song.addEventListener(Event.COMPLETE, onReady);
				song.load((new URLRequest(pSong)));
				_loaded = true;
			}
			else
			{
				song = null;
				song = new Sound();
				_loaded = false;
				load(pSong);
			}
		}
		
		private function onReady(evt:Event):void
		{
			ready.dispatch();
		}
		
		public function play(evt:Event = null):void
		{
			//song.removeEventListener(Event.COMPLETE, play);
			
			if ( _status == PAUSED )
			{
				if ( loop == LOOP_INDEFINITELY )
					channel = song.play((_pausedTime*1000), int.MAX_VALUE);
				else
					channel = song.play((_pausedTime*1000), loop);
			}
			else
			{
				if ( loop == LOOP_INDEFINITELY )
					channel = song.play(0, int.MAX_VALUE);
				else
					channel = song.play(0, loop);
			}
			channel.soundTransform = transform;
			channel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			_status = PLAYING;
			timer.start();
		}
		
		public function pause():void
		{
			if ( channel != null )
			{
				timer.stop();
				channel.stop();
			}
			_status = PAUSED;
		}
		
		public function stop():void
		{
			if ( channel != null )
			{
				channel.stop();
				channel = null;
			}
			_pausedTime = 0;
			_status = STOPPED;
		}
		
		public function getSoundLength():Number
		{
			return song.length;
		}
		
		public function get status():uint
		{
			return _status;
		}
		
		public function set file(pFile:String):void
		{
			_file = pFile;
		}
			
	}

}
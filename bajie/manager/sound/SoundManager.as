package bajie.manager.sound 
{
	import flash.utils.Dictionary;
	import flash.media.SoundTransform;
	import flash.media.SoundChannel;
	import bajie.manager.SharedObjectManager;
	import flash.media.Sound;
	import bajie.core.data.GlobalAPI;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	
	public class SoundManager 
	{
		/**
		普通按钮
		*/
		public static const COMMON_BTN:String = "1001";
		
		/**
		选项卡按钮
		*/
		public static const TAB_BTN:String = "1002";
		
		/**
		升级
		*/
		public static const UPGRADE:String = "1004";
		
		/**
		物品拿起放下
		*/
		public static const ITEM_DRAG:String = "1005";
		
		/**
		点击排雷格子
		*/
		public static const MINE_GRID_CLICK:String = "1006";
		
		/**
		各种道具声音
		*/
		
		
		private static var _soundDict:Dictionary;
		
		private static var _instance:SoundManager;
		public static function get instance():SoundManager
		{
			if(_instance == null)
			{
				_instance = new SoundManager();
			}
			return _instance;
		}
		
		private var _isSoundMute:Boolean;
		private var _isMusicMute:Boolean;
		private var _soundTransform:SoundTransform;
		private var _bgMusicTransform:SoundTransform;
		private var _soundList:Dictionary;
		private var _musicChannel:SoundChannel;
		private var _currentMusic:int;

		public function SoundManager() 
		{
			// constructor code
			_currentMusic = -1;
			_soundList = new Dictionary();
			_soundDict = new Dictionary();
			_soundTransform = new SoundTransform(SharedObjectManager.soundVolumn.value);
			_bgMusicTransform = new SoundTransform(SharedObjectManager.bgMusicVolumn.value);
		}
		
		public function playSound(s:String, loops:int = 0, stopOther:Boolean = true):void
		{
			if(_isSoundMute)
				return;
			try
			{
				if(stopOther)
					stopAllSound();
				if(_soundDict[s] == null)
				{
					var ss:Sound = GlobalAPI.loaderAPI.getObjectByClassPath(GloabalAPI.pathManager.getSoundClassPath(s)) as Sound;
					_soundDict[s] = ss;
				}
				if(_soundDict[s])
				{
					if(loops == -1)
						loops = int.MAX_VALUE;
					var c:SoundChannel = Sound(_soundDict[s]).play(0, loops, _soundTransform);
					c.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
					_soundList[s] = c;
				}
			}
			catch(e:Error)
			{
				trace(e.message);
			}
		}
		
		private function stopAllSound():void
		{
			for(var i:String in _soundList)
			{
				stopSound(i);
			}
		}
		
		public function stopSound(s:String):void
		{
			if(_soundList[s] != null)
			{
				Sound(_soundList[s]).removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
				_soundList[s].stop();
				_soundList[s] = null;
			}
		}
		
		private function soundCompleteHandler(e:Event):void
		{
			var c:SoundChannel = e.currentTarget as SoundChannel;
			c.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			c.stop();
			for(var i:String in _soundList)
			{
				if(_soundList[i] == c)
				{
					_soundList[i] = null;
					return;
				}
			}
		}
		
		public function playBackgroup(id:int):void
		{
			if(_currentMusic == id)
				return;
			_currentMusic = id;
			if(_isMusicMute)
				return;
			if(_musicChannel)
				_musicChannel.stop();
			try
			{
				var ss:Sound = new Sound(new URLRequest(GlobalAPI.pathManager.getMusicPath(id)));
				var c:SoundChannel = ss.play(0, 10000000, _bgMusicTransform);
				ss.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
			}
		}

	}
	
}

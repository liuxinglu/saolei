package bajie.manager 
{
	import flash.net.SharedObject;
	import bajie.core.data.SharedObjectInfo;
	import bajie.module.ModuleEventDispatcher;
	import bajie.events.CommonModuleEvent;
	
	public class SharedObjectManager 
	{
		/**
		音效音量
		*/
		public static const soundVolumn:SharedObjectInfo = new SharedObjectInfo("soundVolumn", 0.6);
		public static function setSoundVolumn(value:Number):void
		{
			if(soundVolumn.value == value)
			{
				return;
			}
			soundVolumn.value = value;
		}
		
		/**
		背景音乐音量
		*/
		public static const bgMusicVolumn:SharedObjectInfo = new SharedObjectInfo("bgMusicVolumn", 0.6);
		public static function setBgMusicVolumn(value:Number):void
		{
			if(bgMusicVolumn.value == value)
			{
				return;
			}
			bgMusicVolumn.value = value;
		}
		
		/**
		背景音乐开关
		*/
		public static const bgMusicEnable:SharedObjectInfo = new SharedObjectInfo("bgMusicEnable", true);
		public static function setBgMusicEnable(value:Boolean):void
		{
			if(bgMusicEnable.value == value)
			{
				return;
			}
			bgMusicEnable.value = value;
			ModuleEventDispatcher.dispatchCommonModuleEvent(new CommonModuleEvent(CommonModuleEvent.VOICE_CHANGE));
		}
		
		/**
		音效开关
		*/
		public static const soundEnable:SharedObjectInfo = new SharedObjectInfo("soundEnable", true);
		public static function setSoundEnable(value:Boolean):void
		{
			if(soundEnable.value == value)
			{
				return;
			}
			soundEnable.value = value;
			ModuleEventDispatcher.dispatchCommonModuleEvent(new CommonModuleEvent(CommonModuleEvent.VOICE_CHANGE));
		}
		
		/**
		接受战斗邀请
		*/
		public static const frightInviteEnable:SharedObjectInfo = new SharedObjectInfo("frightInviteEnable", true);
		public static function setFrightInviteEnable(value:Boolean):void
		{
			if(frightInviteEnable.value == value)
			{
				return;
			}
			frightInviteEnable.value = value;
		}
		
		/**
		引导功能提示
		*/
		public static const guideTipEnable:SharedObjectInfo = new SharedObjectInfo("guideTipEnable", true);
		public static function setGuideTipEnable(value:Boolean):void
		{
			if(guideTipEnable.value == value)
			{
				return;
			}
			guideTipEnable.value = value;
		}
		
		/**
		屏蔽私聊
		*/
		public static const privateChatEnable:SharedObjectInfo = new SharedObjectInfo("privateChatEnable", true);
		public static function setPrivateChatEnable(value:Boolean):void
		{
			if(privateChatEnable.value == value)
			{
				return;
			}
			privateChatEnable.value = value;
		}
		
		/**
		好友上线提醒
		*/
		public static const friendOnlineRemind:SharedObjectInfo = new SharedObjectInfo("friendOnlineRemind", true);
		public static function setFriendOnlineRemind(value:Boolean):void
		{
			if(friendOnlineRemind.value == value)
			{
				return;
			}
			friendOnlineRemind.value = value;
		}
		
		/**
		允许加为好友
		*/
		public static const allowAddFriend:SharedObjectInfo = new SharedObjectInfo("allowAddFriend", true);
		public static function setAllowAddFriend(value:Boolean):void
		{
			if(allowAddFriend.value == value)
			{
				return;
			}
			allowAddFriend.value = value;
		}
		
		public static function setup():void
		{
			try
			{
				var so:SharedObject = SharedObject.getLocal("bajieSetting");
				if(so && so.data)
				{
					if(so.data[soundVolumn.key] != undefined)
						soundVolumn.value = so.data[soundVolumn.key];
						
					if(so.data[bgMusicVolumn.key] != undefined)
						soundVolumn.value = so.data[bgMusicVolumn.key];
						
					if(so.data[bgMusicEnable.key] != undefined)
						bgMusicEnable.value = so.data[bgMusicEnable.key];
					else
						bgMusicEnable.value = true;
						
					if(so.data[soundEnable.key] != undefined)
						soundEnable.value = so.data[soundEnable.key];
					else
						soundEnable.value = true;
						
					if(so.data[frightInviteEnable.key] != undefined)
						frightInviteEnable.value = so.data[frightInviteEnable.key];
						
					if(so.data[guideTipEnable.key] != undefined)
						guideTipEnable.value = so.data[guideTipEnable.key];
						
					if(so.data[privateChatEnable.key] != undefined)
						privateChatEnable.value = so.data[privateChatEnable.key];
					
					if(so.data[friendOnlineRemind.key] != undefined)
						friendOnlineRemind.value = so.data[friendOnlineRemind.key];
					
					if(so.data[allowAddFriend.key] != undefined)
						allowAddFriend.value = so.data[allowAddFriend.key];
					
					Sound
						
				}
			}
		}

		public function SharedObjectManager() {
			// constructor code
		}

	}
	
}

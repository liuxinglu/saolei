package bajie.core.data.userSet 
{
	import flash.events.EventDispatcher;
	import bajie.core.data.socketHandler.userSet.*;
	import bajie.events.ParamEvent;
	import bajie.core.data.GlobalData;
	/**
	 * ...
	 * @author azjune
	 */
	public class UserSetInfo extends EventDispatcher
	{
		
		public function UserSetInfo() 
		{
			
		}
		/*
		 * 发送获取游戏设置信息
		 */
		public function enterUserSetInfo():void
		{
			EnterUserSetSocketHandler.send(GlobalData.playerid);
		}
		/*
		 * 成功更改用户配置
		 */
		public function completeUserSet(o:Object):void {
			GlobalData.music = o.music;
			GlobalData.sound = o.sound;
			GlobalData.invite = o.invite;
			GlobalData.guide = o.guide;
			GlobalData.prompt = o.prompt;
			GlobalData.whisper = o.whisper;
			GlobalData.friends = o.friends;
			GlobalData.fashion = o.fashion;
			
			this.dispatchEvent(new ParamEvent(ParamEvent.GET_USER_SET,o));
			//trace("设置步骤4");
		}
		
		/*
		 * 设置游戏
		 */
		public function sendUserSet(music:int,sound:int,invite:int,guide:int,prompt:int,whisper:int,friends:int,fashion:int):void {
			UserSetSocketHandler.send(GlobalData.playerid,music,sound,invite,guide,prompt,whisper,friends,fashion);
		}
		
	}

}
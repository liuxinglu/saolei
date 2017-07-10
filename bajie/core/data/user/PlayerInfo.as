package bajie.core.data.user
{
	import bajie.core.data.GlobalData;
	import bajie.core.data.socketHandler.player.GetSimplePlayerInfoSocketHandler;
	import bajie.core.data.socketHandler.register.RandomAttSocketHandler;
	import bajie.core.data.socketHandler.register.RegisterPlayerSocketHandler;
	import bajie.core.data.user.vo.UserVO;
	import bajie.events.ParamEvent;
	
	import flash.events.EventDispatcher;
	
	public class PlayerInfo extends EventDispatcher
	{
		public var userVO:UserVO;
		public function PlayerInfo()
		{
			userVO = new UserVO;
		}
		
		public function randomAtt(playerid:uint):void
		{
			RandomAttSocketHandler.send(playerid);
		}
		
		/**
		 * 创建角色
		 * @param playerId 用户id
		 * @param name 昵称
		 * @param sex 性别
		 * @param energy 能量
		 * @param lucky 幸运
		 * @param dexterity 灵巧
		 * @param ip 用户ip（目前没用）
		 * 
		 */		
		public function createPlayer(playerId:uint, name:String, sex:int, energy:int, lucky:int, dexterity:int, ip:String=""):void
		{
			RegisterPlayerSocketHandler.send(playerId, name, sex, energy, lucky, dexterity, ip);
		}
		
		public function updateUserInfo(o:Object):void
		{
			
		}
		
		//获取简单用户信息
		public function getSimplePlayer():void
		{
			GetSimplePlayerInfoSocketHandler.send();
		}
		
		//获得简单用户信息
		public function getSimplePlayerInfo(o:Object):void
		{
			GlobalData.playerInfo.userVO.name = o.name.toString();
			GlobalData.playerInfo.userVO.level = o.level.toString();
			GlobalData.playerInfo.userVO.bufferVip = o.buffervip;
			GlobalData.playerInfo.userVO.bufferExp = o.bufferexp;
			GlobalData.playerInfo.userVO.bufferEnergy = o.bufferenergy;
			GlobalData.playerInfo.userVO.bufferLucky = o.bufferlucky;
			GlobalData.playerInfo.userVO.bufferDexterity = o.bufferdexterity;
			GlobalData.playerInfo.userVO.bufferSkill = o.bufferskill;
			
			this.dispatchEvent(new ParamEvent(ParamEvent.GET_SIMPLE_PLAYER_INFO, o));
		}
	}
}
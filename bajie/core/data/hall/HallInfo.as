package bajie.core.data.hall
{
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.room.vo.RoomVO;
	import bajie.core.data.socketHandler.hall.HallInfoSocketHandler;
	import bajie.core.data.socketHandler.room.CreateRoomSocketHandler;
	import bajie.core.data.socketHandler.room.EnterRoomSocketHandler;
	import bajie.core.data.socketHandler.room.HostKickPlayerSocketHandler;
	import bajie.core.data.socketHandler.room.OCRoomSiiteSocketHandler;
	import bajie.core.data.socketHandler.room.SearchRoomSocketHandler;
	import bajie.core.data.socketHandler.room.UserExitRoomSocketHandler;
	import bajie.core.data.socketHandler.room.UserRCStateSocketHandler;
	import bajie.core.data.socketHandler.room.UserStartGameSocketHandler;
	import bajie.events.ParamEvent;
	import bajie.interfaces.loader.ILoader;
	import bajie.ui.Fight;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.events.EventDispatcher;
	import flash.utils.setTimeout;
	import flash.events.Event;

	public class HallInfo extends EventDispatcher
	{
		
		public function HallInfo()
		{
			
		}
		
		/**
		 *点击大厅 发送大厅数据请求 
		 * @param playerid
		 * 
		 */		
		public function enterHall(playerid:uint):void
		{
			HallInfoSocketHandler.send(playerid);
			
		}
		
		/**
		 *获取大厅列表数据 
		 * @param o
		 * 
		 */		
		public function getHallInfo(o:Object):void
		{
			this.dispatchEvent(new ParamEvent(ParamEvent.GET_HALL_INFO, o));
		}
		
		/**
		 *创建房间 
		 * @param vo
		 * 
		 */		
		public function createRoom(vo:RoomVO):void
		{
			CreateRoomSocketHandler.send(vo);
		}
		
		/**
		 *请求进入房间 
		 * @param roomId
		 * 
		 */		
		public function enterRoom(roomId:uint):void
		{
			EnterRoomSocketHandler.send(roomId);
			
		}
		
		/**
		 *获得房间数据 
		 * @param o
		 * 
		 */		
		public function getRoomInfo(o:Object):void
		{
			this.dispatchEvent(new ParamEvent(ParamEvent.GET_ROOM_INFO, o));
			if(!GlobalData.fightInfo.hasEventListener(ParamEvent.GET_BATTLE_FIELD_INFO))
				GlobalData.fightInfo.addEventListener(ParamEvent.GET_BATTLE_FIELD_INFO, enterFight);
		}
		
		/**
		 *查找房间 
		 * @param roomSearchContent 房间查找内容 房间名或房间id
		 * @param password 密码
		 * 
		 */		
		public function searchRoom(roomSearchContent:String= "", password:String = ""):void
		{
			SearchRoomSocketHandler.send(roomSearchContent, password);
		}
		
		/**
		 *房主踢人 
		 * @param roomid 房间id
		 * @param index 所踢的位置
		 * 
		 */		
		public function hostKickPlayer(roomid:int, index:int):void
		{
			HostKickPlayerSocketHandler.send(GlobalData.playerid, roomid, index);
		}
		
		/**
		 *房主关闭房间位 
		 * @param roomid 房间id
		 * @param index 所关闭的位置
		 * 
		 */		
		public function ocRoomSite(roomid:int, index:int):void
		{
			OCRoomSiiteSocketHandler.send(GlobalData.playerid, roomid, index);
		}
		
		/**
		 *退出房间 
		 * @param roomId 房间id
		 * 
		 */		
		public function exitRoom(roomId:int):void
		{
			UserExitRoomSocketHandler.send(GlobalData.playerid, roomId);
		}
		
		public function exitRoomInfo(o:Object):void
		{
			this.dispatchEvent(new ParamEvent(ParamEvent.EXIT_SUCCESS));
		}
		
		/**
		 *准备、取消 
		 * @param roomId 房间id
		 * 
		 */		
		public function ready_cancel(roomId:int):void
		{
			UserRCStateSocketHandler.send(roomId);
		}
		
		private var _e:ParamEvent;
		private function enterFight(e:ParamEvent):void
		{
			_e = e;
			SetModuleUtils.addMod(ModuleType.FIGHT, funFightHandler);
		}
		
		private function funFightHandler(cl:Class):void
		{
			setTimeout(function ta():void{
				
				var fightSp:Fight = new Fight();
				fightSp.name = "fight";
				
				SetModuleUtils.addModule(fightSp, null, false, false, ModuleType.FIGHT);
				fightSp.initData(_e);
				
			},200);
		}
		
		/**
		 *开始玩游戏 
		 * @param roomId 房间id
		 * 
		 */		
		public function startGame(roomId:int):void
		{
			UserStartGameSocketHandler.send(roomId);   
			GlobalData.fightInfo.addEventListener(ParamEvent.GET_BATTLE_FIELD_INFO, enterFight);
//			GlobalAPI.loaderAPI.loadSwf(GlobalAPI.pathManager.getModulePath(ModuleType.FIGHT), _loaderReady, 0);
//			function _loaderReady(loader:ILoader):void
//			{
//				setTimeout(function ta():void{
//						var fightSp:Fight = new Fight();
//				SetModuleUtils.addModule(fightSp);
//				
//				UserStartGameSocketHandler.send(roomId);   
//						   },500);
//				
//			}
			
		}
	}
}
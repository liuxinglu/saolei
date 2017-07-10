package bajie.ui
{
	import bajie.constData.CommonConfig;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.user.vo.PlayerVO;
	import bajie.ui.room.RoomPlayerList;
	import bajie.utils.SaoLeiTool;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	import bajie.events.ParamEvent;
	
	public class Room extends MovieClip
	{
		private var playerListNumber:int = 4;
		private static var _rom:Room;
		private static var _room:*;
		
		private var playerList:Array = [];
		
		private var _readyPlayer:int = -1;
		private var playerNumber:int = -1;
		
		private var roomId:int = -1;
		
		private var _playerBtnState:int = 1;
		
		public static function getInstance():Room
		{
			if (_rom == null)
				_rom = new Room();
			return _rom;
		}
		
		public function Room()
		{
			//if(_room == null)
			_room = GlobalAPI.loaderAPI.getObjectByClassPath("room");
			addChild(_room);
			initPlayerList();
			initEvent();
		}
		
		public function initEvent():void
		{
			_room.reback.addEventListener(MouseEvent.CLICK, closeHandler);
			
			//准备 取消 开始按钮
			setBtnState(1, false);
			_room.btn_ready.addEventListener(MouseEvent.CLICK, readyClickHandler);
			
			_room.reback.addEventListener(MouseEvent.CLICK, closeHandler);
			
			//快速换房
			_room.btn_huanfang.addEventListener(MouseEvent.CLICK, quickChangeRoomClickHandler);
			
			GlobalData.hallInfo.addEventListener(ParamEvent.EXIT_SUCCESS, exitRoom);
			this.visible = true;
		}
		private function initPlayerList():void {
			for (var i:int = 0; i < playerListNumber;i++ ) {
				var _player:RoomPlayerList = new RoomPlayerList();
				_player.initMC(true);
				_player.x = 50+_player.width*i;
				_player.y = 105;
				_player.index = i;
				_room.addChild(_player);
				playerList.push(_player);
			}
		}
		
		
		/**
		   初始化界面数据<br/>
		   teamid":1636,"name":"测试房间","level":3,"map":2,"shut":false,"mode":1,"grade":3,"
		   member":"[{"playerid":3,"name":"r","sex":1,"
		   avatar":"http://share.bajiegame.com/dungeon/images/job11.png","
		   level":1,"vip":0,"energy":0,"lucky":0,"dexterity":0,"exp":0,"skill":0,"index":0,"ready":1,"captain":1,"
		   me":1,"weapon":0}]","
		   close":"[1,1,1,0]"}
		 */
		public function initData(o:Object):void
		{
			SetModuleUtils.removeLoading();
			_room.roomId.text = o.teamid;
			_room.roomName.text = o.name;
			_room.roomMode.modeName.text = SaoLeiTool.getModeName(o.mode, o.grade);
			_room.roomMap.mapName.text = SaoLeiTool.getMapName(o.map);
			
			roomId = o.teamid;
			
			//填充玩家位信息
			var closeObject:Array = o.close as Array;
			var closeLen:int = closeObject.length;
			
			for (var j:int = 0; j < closeLen; j++)
			{
				if (closeObject[j] == 1)
				{
					playerList[j].initMC(true); //打开位
				}else {
					playerList[j].initMC(false);
				}
			}
			
			//填充玩家数据
			var playerArr:Array = o.member as Array;
			playerNumber = playerArr.length;
			_readyPlayer = 0;
			var myindex:int = 0;
			for (var i:int = 0; i < playerNumber; i++)
			{
				playerList[playerArr[i].index].initMC(true,playerArr[i]);
				if (playerArr[i].me == 1) {
					myindex = playerArr[i].index;
				}
				if (playerArr[i].ready == 1)_readyPlayer++;
			}
			
			for (var k:int = 0; k < playerListNumber; k++ ) {
				//设置房间号
				playerList[k].teamid = roomId;
				//设置是否可以被踢出
				if (playerList[myindex].captain == 1) {
					playerList[k].isControl = true;
					if ((playerList[k].openState == 2)&&(playerList[k].me!=1)) {
						playerList[k].setKickEnable(true);
					}else{
						playerList[k].setKickEnable(false);
					}
				}else {
					playerList[k].isControl = false;
					playerList[k].setKickEnable(false);
				}
			}
			//设置按钮状态
			if(playerList[myindex].captain == 1){//如果是队长
				if ((_readyPlayer == playerNumber)&&(playerNumber > 1)) {//可以开始
					setBtnState(3, true);
				}else {
					setBtnState(3, false);
				}
			}else{//如果不是队长
				if (playerList[myindex].ready == 1) {//取消
					setBtnState(2, true);
				}
				else {//准备
					setBtnState(1, true);
				}
			}
		}
		
		/**
		 * 设置按钮状态
		 * @param	btn 1准备2取消3开始
		 * @param	boo 是否可用
		 */
		private function setBtnState(btn:int, boo:Boolean):void {
			if (btn == 1) {
				_room.btn_ready.txt.gotoAndStop("ready");
				_playerBtnState = 1;
			}else if(btn == 2){
				_room.btn_ready.txt.gotoAndStop("cancel");
				_playerBtnState = 2;
			}else if (btn == 3) {
				_room.btn_ready.txt.gotoAndStop("start");
				_playerBtnState = 3;
			}
			if (boo) {
				_room.btn_ready.gotoAndStop("_up");
				_room.btn_ready.mouseEnabled = true;
			}else {
				_room.btn_ready.gotoAndStop("non");
				_room.btn_ready.mouseEnabled = false;
			}
		}
		
		private function readyClickHandler(e:MouseEvent):void {
			if (_playerBtnState == 1) {
				GlobalData.hallInfo.ready_cancel(roomId);
			}
			if (_playerBtnState == 2) {
				GlobalData.hallInfo.ready_cancel(roomId);
			}
			if (_playerBtnState == 3) {
				GlobalData.hallInfo.startGame(roomId);
			}
		}
		
		public function removeEvent():void
		{
			_room.reback.removeEventListener(MouseEvent.CLICK, closeHandler);
			
			//准备 取消 开始按钮
			_room.btn_ready.removeEventListener(MouseEvent.CLICK, readyClickHandler);
			
			_room.reback.removeEventListener(MouseEvent.CLICK, closeHandler);
			//快速换房
			_room.btn_huanfang.removeEventListener(MouseEvent.CLICK, quickChangeRoomClickHandler);
			
			GlobalData.hallInfo.removeEventListener(ParamEvent.EXIT_SUCCESS, exitRoom);
		}
		
		//退出
		private function closeHandler(e:MouseEvent):void
		{
			GlobalData.hallInfo.exitRoom(roomId);
		}
		private function exitRoom(e:ParamEvent):void {
			//removeEvent();
			//for (var k:int = 0; k < playerListNumber; k++ ) {
				//playerList[k].removeMC();
			//}
			//_room = null;
			//_rom = null;
			//playerList = null;
			//SetModuleUtils.removeModule(this);
			this.visible = false;
		}
		
		//快速加入房间
		private function quickChangeRoomClickHandler(e:MouseEvent):void
		{
			
		}
	}
}
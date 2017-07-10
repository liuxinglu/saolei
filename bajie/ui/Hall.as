package bajie.ui
{
	
	import bajie.constData.CommonConfig;
	import bajie.constData.GoodsType;
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.bag.BagItemInfo;
	import bajie.core.data.hall.vo.HallInfoRoomItem;
	import bajie.events.ParamEvent;
	import bajie.interfaces.loader.ILoader;
	import bajie.ui.att.AttItem;
	import bajie.ui.hall.CreateRoomPanel;
	import bajie.ui.hall.RoomItem;
	import bajie.ui.hall.SearchRoomPanel;
	import bajie.utils.SaoLeiTool;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class Hall extends MovieClip {
		
		private var loader:ILoader;
		private var roomList:Array = [];
		private var _hall:*;
		private var curModeList:Array = [];//列表中当前选择的模式列表
		private var curMapList:Array = [];//列表中当前选择的地图列表
		
		public function getInstance():*
		{
			if(_hall == null || _hall == undefined)
			{
				_hall = GlobalAPI.loaderAPI.getObjectByClassPath("hall");
			}
			return _hall;
		}
		
		public function Hall() {
			try{
				getInstance();
			}
			catch(e:Error)
			{
				SetModuleUtils.removeLoading();
				return;
			}
			addChild(_hall);
			drawAttItem();
			initEvent();
		}
		
		//画人物道具技能格子
		private function drawAttItem():void
		{
			var attItem:AttItem;
			for (var i:int = 0; i < 9; i++)
			{//
				attItem = new AttItem  ;
				attItem.name = "grid";
				var tempi:int = i + 1;
				attItem.index = tempi;
				
				if ((i < 4))
				{
					attItem.itemType = ModuleType.ROLE;
					attItem.infoTextMC.gotoAndStop(12);
					_hall["prop" + i].addChild(attItem);
				}
				else if ((i < 8))
				{
					attItem.itemType = ModuleType.SKILL;
					attItem.infoTextMC.gotoAndStop(14);
					_hall["skill" + (i-4)].addChild(attItem);
				}
				else
				{
					attItem.infoTextMC.gotoAndStop(11);
					_hall["weapon"].addChild(attItem);
				}
			}
			
		}
		
		
		
		public function initEvent():void
		{
			GlobalData.hallInfo.addEventListener(ParamEvent.GET_HALL_INFO, getHallInfoHandler, false, 0, true);
			GlobalData.hallInfo.addEventListener(ParamEvent.GET_ROOM_INFO, getRoomInfoHandler, false, 0, true);
			GlobalData.playerInfo.addEventListener(ParamEvent.GET_SIMPLE_PLAYER_INFO, getSimpleInfoHandler, false, 0, true);
			_hall.showWaitRoom.buttonMode = true;
			_hall.showWaitRoom.gotoAndStop(1);
			_hall.selMode.buttonMode = true;
			_hall.selMode.gotoAndStop(1);
			_hall.selMap.buttonMode = true;
			_hall.selMap.gotoAndStop(1);
			_hall.showWaitRoom.addEventListener(MouseEvent.CLICK, showWaitRoomClickHandler);
			
			_hall.selMap.addEventListener(MouseEvent.CLICK, selMapClickHandler);
			
			_hall.selMode.addEventListener(MouseEvent.CLICK, selModeClickHandler);
			
			_hall.closeBtn.addEventListener(MouseEvent.CLICK, closeHandler);
			_hall.prePageBtn.addEventListener(MouseEvent.CLICK, prePageHandler);
			_hall.refreshBtn.addEventListener(MouseEvent.CLICK, refreshHandler);
			_hall.nextPageBtn.addEventListener(MouseEvent.CLICK, nextPageHandler);
			_hall.createRoom.addEventListener(MouseEvent.CLICK, createRoomHandler);
			_hall.findRoom.addEventListener(MouseEvent.CLICK, findRoomHandler);
		}
		
		private function selMapClickHandler(e:MouseEvent):void
		{
			_hall.selMap.gotoAndStop(2);
			
		}
		
		private function selModeClickHandler(e:MouseEvent):void
		{
			_hall.selMode.gotoAndStop(2);
			initSelModeEvent();
			
		}
		
		private function initSelModeEvent():void
		{
			_hall.selMode.sanjiao.addEventListener(MouseEvent.CLICK, sanjiaoClickHandler);
			for(var i:int = 0; i < 9; i++)
			{
				_hall.selMode["mode" + i].addEventListener(MouseEvent.MOUSE_OVER, selModeOverHandler);
				_hall.selMode["mode" + i].addEventListener(MouseEvent.MOUSE_OUT, selModeOutHandler);
				_hall.selMode["mode" + i].addEventListener(MouseEvent.CLICK, selModeSubClickHandler);
				_hall.selMode["mode" + i].checkBox.visible = false;
			}
		}
		
		private function removeSelModeEvent():void
		{
			for(var i:int =0; i < 9; i++)
			{
				_hall.selMode["mode" + i].removeEventListener(MouseEvent.MOUSE_OVER, selModeOverHandler);
				_hall.selMode["mode" + i].removeEventListener(MouseEvent.MOUSE_OUT, selModeOutHandler);
				_hall.selMode["mode" + i].removeEventListener(MouseEvent.CLICK, selModeSubClickHandler);
			}
		}
		
		private function sanjiaoClickHandler(e:MouseEvent):void
		{
			removeSelModeEvent();
			_hall.selMode.gotoAndStop(1);
		}
		
		private function selModeSubClickHandler(e:MouseEvent):void
		{
			var s:String = e.currentTarget.name;
			trace(s);
		}
		
		private function selModeOverHandler(e:MouseEvent):void
		{
			e.currentTarget.gotoAndStop(2);
		}
		
		private function selModeOutHandler(e:MouseEvent):void
		{
			e.currentTarget.gotoAndStop(1);
		}
		
		private var _showWaitRoomFlag:Boolean = false;
		private function showWaitRoomClickHandler(e:MouseEvent):void
		{
			_showWaitRoomFlag = !_showWaitRoomFlag;
			_hall.showWaitRoom.right.visible = _showWaitRoomFlag;
			if(_showWaitRoomFlag)
			{
				//发请求用来获取信息
				//等等呢个等
			}
			else
			{
				
			}
		}
		//获取列表数据
		private function getHallInfoHandler(e:ParamEvent):void
		{
			var o:Object = e.Param;
			var mo:Object = o.body;
			roomList = mo as Array;
			var len:int = roomList.length;
			getInstance();
			for(var j:int = 0; j < MovieClip(_hall.roomListContent).numChildren; j++)
			{
				RoomItem(MovieClip(_hall.roomListContent).getChildAt(j)).removeEvent();
			}
			MovieClip(_hall.roomListContent).removeChildren();
			
			for(var i:int = 0; i < len; i++)
			{
				var roomItem:RoomItem;
				roomItem = new RoomItem;
				roomItem.roomId.text = roomList[i].teamid;
				roomItem.roomName.text = roomList[i].name;
				roomItem.mapName.text = SaoLeiTool.getMapName(roomList[i].map);
				roomItem.mode.text = SaoLeiTool.getModeName(roomList[i].mode, roomList[i].grade);
				roomItem.peopNum.text = roomList[i].count + "/" + roomList[i].number;
				roomItem.isFight.visible = roomList[i].doing == 1? true: false;
				roomItem.hasPassword.visible = roomList[i].password == 0 ? false: true;
				roomItem.x = 0;
				roomItem.y = (roomItem.height + 2) * i;
				_hall.roomListContent.addChild(roomItem);
			}
		}
		
		//获取房间信息进入房间
		private var room:Room;
		private var roomO:Object;
		private function getRoomInfoHandler(e:ParamEvent):void
		{
			//GlobalData.hallInfo.removeEventListener(ParamEvent.GET_ROOM_INFO, getRoomInfoHandler);
			var o:Object = e.Param;
			roomO = o;
			
			if(!room)
			{
				SetModuleUtils.addMod(ModuleType.ROOM, funRoomHandler);
			}
			else
			{
				room.visible = true;
				room.initData(o);
			}
		}
		
		private function funRoomHandler(cl:Class):void
		{
			room = Room.getInstance();
			room.initData(roomO);
			SetModuleUtils.addModule(room, _hall, false, false, ModuleType.ROOM);
		}
		
		public function getSimpleInfoHandler(e:ParamEvent):void
		{
			SetModuleUtils.removeLoading();
			var o:Object = e.Param;
			
			_hall.playerMC.levelText.text = o.level.toString();
			_hall.playerMC.playerName.text = o.name.toString();
			o.buffervip > 0?_hall.playerMC.buffer0.gotoAndStop(2):_hall.playerMC.buffer0.gotoAndStop(1);
			o.bufferexp > 0?_hall.playerMC.buffer1.gotoAndStop(2):_hall.playerMC.buffer1.gotoAndStop(1);
			o.bufferenergy > 0?_hall.playerMC.buffer2.gotoAndStop(2):_hall.playerMC.buffer2.gotoAndStop(1);
			o.bufferlucky > 0?_hall.playerMC.buffer3.gotoAndStop(2):_hall.playerMC.buffer3.gotoAndStop(1);
			o.bufferdexterity > 0?_hall.playerMC.buffer4.gotoAndStop(2):_hall.playerMC.buffer4.gotoAndStop(1);
			o.bufferskill > 0?_hall.playerMC.buffer5.gotoAndStop(2):_hall.playerMC.buffer5.gotoAndStop(1);
			var oo2:Object = o.weapon;
			var info:BagItemInfo;
			for(var i:int = 0; i < oo2.length; i++)
			{
				if(oo2[i].type == GoodsType.WEAPON)
				{
					info = new BagItemInfo  ;
					info.binder = oo2[i].binder;
					info.itemId = oo2[i].idx;
					info.templateId = oo2[i].openid;
					info.position = oo2[i].position;
					info.number = oo2[i].quantity;
					info.type = oo2[i].type;
					info.wear = oo2[i].wear;
					info.classify = oo2[i].classify;
					info.energy = oo2[i].energy;
					info.lucky = oo2[i].lucky;
					info.dex = oo2[i].dexterity;
					info.additEnergy = oo2[i].energy1;
					info.additLucky = oo2[i].lucky1;
					info.additDex = oo2[i].dexterity1;
					info.inside = oo2[i].inside;
					
					AttItem(MovieClip(_hall["weapon"]).getChildByName("grid")).info = info;
					AttItem(MovieClip(_hall["weapon"]).getChildByName("grid")).initBagCell();
					AttItem(MovieClip(_hall["weapon"]).getChildByName("grid")).index = 11;
				}
			}
			
			var propO:Object = o.props;
			
			for(var j:int = 0; j < propO.length; j++)
			{
				info = new BagItemInfo ;
				info.binder = propO[j].binder;
				info.itemId = propO[j].idx;
				info.templateId = propO[j].openid;
				info.position = propO[j].position;
				info.number = propO[j].quantity;
				info.type = propO[j].type;
				info.inside = propO[j].inside;
				AttItem(MovieClip(_hall["prop" + (info.inside-1)]).getChildByName("grid")).info = info;
				AttItem(MovieClip(_hall["prop" + (info.inside-1)]).getChildByName("grid")).initBagCell();
				AttItem(MovieClip(_hall["prop" + (info.inside-1)]).getChildByName("grid")).index = info.inside;
			}
			
			var skillO:Object = o.skills;
			for(var k:int = 0; k < skillO.length; k++)
			{
				info = new BagItemInfo;
				info.itemId = skillO[k].idx;
				info.type = skillO[k].type;
				info.position = skillO[k].position;
				info.inside = skillO[k].inside;
				info.templateId = skillO[k].openid;
				info.level = skillO[k].level;
				info.learn = skillO[k].learn;
				AttItem(MovieClip(_hall["skill" + (info.inside - 1)]).getChildByName("grid")).info = info;
				AttItem(MovieClip(_hall["skill" + (info.inside - 1)]).getChildByName("grid")).initBagCell();
				AttItem(MovieClip(_hall["skill" + (info.inside - 1)]).getChildByName("grid")).index = info.inside;
			}
			
			
		}
		
		private function closeHandler(e:MouseEvent):void
		{
			removeEvent();
			SetModuleUtils.removeModule(this, ModuleType.HALL);
			//this = null;
		}
		
		private function createRoomHandler(e:MouseEvent):void
		{
			var createRoomPanel:CreateRoomPanel = new CreateRoomPanel;
			SetModuleUtils.addModule(createRoomPanel, null, true, false, ModuleType.CREATE_ROOM);
		}
		
		//查找房间
		private function findRoomHandler(e:MouseEvent):void
		{
			
			var searchRoom:SearchRoomPanel = new SearchRoomPanel();
			
			SetModuleUtils.addModule(searchRoom, null, true, false, ModuleType.SEARCH_ROOM);
			
		}
		
		private function prePageHandler(e:MouseEvent):void
		{
			
		}
		
		private function refreshHandler(e:MouseEvent):void
		{
			GlobalData.hallInfo.enterHall(GlobalData.playerid);
		}
		
		private function nextPageHandler(e:MouseEvent):void
		{
			
		}
		
		private function removeEvent():void
		{
			for(var j:int = 0; j < MovieClip(_hall.roomListContent).numChildren; j++)
			{
				RoomItem(MovieClip(_hall.roomListContent).getChildAt(j)).removeEvent();
			}
			_hall.closeBtn.removeEventListener(MouseEvent.CLICK, closeHandler);
			_hall.prePageBtn.removeEventListener(MouseEvent.CLICK, prePageHandler);
			_hall.refreshBtn.removeEventListener(MouseEvent.CLICK, refreshHandler);
			_hall.nextPageBtn.removeEventListener(MouseEvent.CLICK, nextPageHandler);
			_hall.createRoom.removeEventListener(MouseEvent.CLICK, createRoomHandler);
			_hall.findRoom.removeEventListener(MouseEvent.CLICK, findRoomHandler);
		}
	}
	
}

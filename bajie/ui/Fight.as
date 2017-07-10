package bajie.ui
{
	import bajie.constData.ClickType;
	import bajie.constData.CommonConfig;
	import bajie.constData.GoodsType;
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.bag.BagItemInfo;
	import bajie.core.data.user.vo.PlayerVO;
	import bajie.events.AlertEvent;
	import bajie.events.GridEvent;
	import bajie.events.ParamEvent;
	import bajie.interfaces.loader.ILoader;
	import bajie.ui.att.AttItem;
	import bajie.ui.fight.MineGrid;
	import bajie.ui.fight.regard.Regard;
	import bajie.utils.LayMines;
	import bajie.utils.SaoLeiTool;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	import flash.geom.Point;

	public class Fight extends MovieClip
	{
		private static var _fightMC:Fight;
		private static var _fight:*;
		private var _roomid:int;
		public var playerList:Array = [];
		private var selfNum:int = 0;//自身雷数显示
		private var curGridName:String;//当前点击格子的名称
		private var _gridSize:int = 0;//0大格子，1小格子
		private var _col:int = 0;//列数
		private var _row:int = 0;//行数
		private var _hasPrize:Boolean = false;

		public static function getInstance():Fight
		{
			if (_fightMC == null)
			{
				_fightMC = new Fight();
			}
			return _fightMC;
		}


		public function Fight()
		{
			initView();
			initEvent();
		}

		private function initView():void
		{
			_hasPrize = false;
			_fight = GlobalAPI.loaderAPI.getObjectByClassPath("fight");
			
			mc = GlobalAPI.loaderAPI.getObjectByClassPath("success");
			
			addChild(_fight);
			_fight["otherPlayer0"].gotoAndStop(2);
			_fight["otherPlayer1"].gotoAndStop(2);
			_fight["otherPlayer2"].gotoAndStop(2);
			_fight.prop1.visible = true;
			_fight.prop2.visible = true;
			_fight.prop3.visible = true;
			_fight.prop4.visible = true;
			_fight.skill1.visible = true;
			_fight.skill2.visible = true;
			_fight.skill3.visible = true;
			_fight.skill4.visible = true;
			_fight.progressBar.visible = false;
		}

		private function initEvent():void
		{
			GlobalData.fightInfo.addEventListener("GAMESUCCESS", gameSuccessHandler);
			GlobalData.fightInfo.addEventListener("GAMEFAIL", gameFailHandler);
			GlobalData.fightInfo.addEventListener(ParamEvent.GET_BATTLE_FIELD_INFO, drawBattleFieldAndDetailsHandler);
			GlobalData.fightInfo.addEventListener(ParamEvent.RE_DRAW_BATTLE_FIELD, reDrawBattleFieldHandler);
			/*GlobalData.fightInfo.addEventListener(AlertEvent.NORMAL_CLOSE, normalCloseHandler);
			GlobalData.fightInfo.addEventListener(AlertEvent.FAIL_CLOSE, failCloseHandler);*/
			GlobalData.hallInfo.addEventListener(ParamEvent.EXIT_SUCCESS, exitRoomSuccessHandler);
			GlobalData.fightInfo.addEventListener(ParamEvent.UPDATE_MINE_NUM, updateMineNumHandler);
			GlobalData.fightInfo.addEventListener(ParamEvent.GET_RANK, closeWindowHandler);
			GlobalData.fightInfo.addEventListener("INVERT_TIME", invertTimeHandler);
			_fight.reback.addEventListener(MouseEvent.CLICK, closeHandler);
			timeLimit.addEventListener(TimerEvent.TIMER, timeLimitHandler);
			boomTime.addEventListener(TimerEvent.TIMER, boomTimeHandler);

			_fight.prop1.addEventListener(MouseEvent.CLICK, prop1ClickHandler, false, 0, true);
			_fight.prop2.addEventListener(MouseEvent.CLICK, prop2ClickHandler, false, 0, true);
			_fight.prop3.addEventListener(MouseEvent.CLICK, prop3ClickHandler, false, 0, true);
			_fight.prop4.addEventListener(MouseEvent.CLICK, prop4ClickHandler, false, 0, true);

			_fight.skill1.addEventListener(MouseEvent.CLICK, skillQClickHandler, false, 0, true);
			_fight.skill2.addEventListener(MouseEvent.CLICK, skillWClickHandler, false, 0, true);
			_fight.skill3.addEventListener(MouseEvent.CLICK, skillEClickHandler, false, 0, true);
			_fight.skill4.addEventListener(MouseEvent.CLICK, skillRClickHandler, false, 0, true);

			_fight.prop1.addEventListener(KeyboardEvent.KEY_UP, prop1KeyHandler, false, 0, true);
			_fight.prop2.addEventListener(KeyboardEvent.KEY_UP, prop2KeyHandler, false, 0, true);
			_fight.prop3.addEventListener(KeyboardEvent.KEY_UP, prop3KeyHandler, false, 0, true);
			_fight.prop4.addEventListener(KeyboardEvent.KEY_UP, prop4KeyHandler, false, 0, true);

			_fight.skill1.addEventListener(KeyboardEvent.KEY_UP, skillQKeyHandler, false, 0, true);
			_fight.skill2.addEventListener(KeyboardEvent.KEY_UP, skillWKeyHandler, false, 0, true);
			_fight.skill3.addEventListener(KeyboardEvent.KEY_UP, skillEKeyHandler, false, 0, true);
			_fight.skill4.addEventListener(KeyboardEvent.KEY_UP, skillRKeyHandler, false, 0, true);
		}

		public function removeEvent():void
		{
			GlobalData.fightInfo.removeEventListener("GAMESUCCESS", gameSuccessHandler);
			GlobalData.fightInfo.removeEventListener("GAMEFAIL", gameFailHandler);
			GlobalData.fightInfo.removeEventListener(ParamEvent.GET_BATTLE_FIELD_INFO, drawBattleFieldAndDetailsHandler);
			GlobalData.fightInfo.removeEventListener(ParamEvent.RE_DRAW_BATTLE_FIELD, reDrawBattleFieldHandler);
			/*GlobalData.fightInfo.removeEventListener(AlertEvent.NORMAL_CLOSE, normalCloseHandler);
			GlobalData.fightInfo.removeEventListener(AlertEvent.FAIL_CLOSE, failCloseHandler);*/
			GlobalData.hallInfo.removeEventListener(ParamEvent.EXIT_SUCCESS, exitRoomSuccessHandler);
			GlobalData.fightInfo.removeEventListener(ParamEvent.UPDATE_MINE_NUM, updateMineNumHandler);
			if(GlobalData.fightInfo.hasEventListener(ParamEvent.GET_RANK))
				GlobalData.fightInfo.removeEventListener(ParamEvent.GET_RANK, closeWindowHandler);
			GlobalData.fightInfo.removeEventListener("INVERT_TIME", invertTimeHandler);
			_fight.reback.removeEventListener(MouseEvent.CLICK, closeHandler);
			timeLimit.removeEventListener(TimerEvent.TIMER, timeLimitHandler);
			boomTime.removeEventListener(TimerEvent.TIMER, boomTimeHandler);

			_fight.prop1.removeEventListener(MouseEvent.CLICK, prop1ClickHandler);
			_fight.prop2.removeEventListener(MouseEvent.CLICK, prop2ClickHandler);
			_fight.prop3.removeEventListener(MouseEvent.CLICK, prop3ClickHandler);
			_fight.prop4.removeEventListener(MouseEvent.CLICK, prop4ClickHandler);

			_fight.skill1.removeEventListener(MouseEvent.CLICK, skillQClickHandler);
			_fight.skill2.removeEventListener(MouseEvent.CLICK, skillWClickHandler);
			_fight.skill3.removeEventListener(MouseEvent.CLICK, skillEClickHandler);
			_fight.skill4.removeEventListener(MouseEvent.CLICK, skillRClickHandler);

			_fight.prop1.removeEventListener(KeyboardEvent.KEY_UP, prop1KeyHandler);
			_fight.prop2.removeEventListener(KeyboardEvent.KEY_UP, prop2KeyHandler);
			_fight.prop3.removeEventListener(KeyboardEvent.KEY_UP, prop3KeyHandler);
			_fight.prop4.removeEventListener(KeyboardEvent.KEY_UP, prop4KeyHandler);

			_fight.skill1.removeEventListener(KeyboardEvent.KEY_UP, skillQKeyHandler);
			_fight.skill2.removeEventListener(KeyboardEvent.KEY_UP, skillWKeyHandler);
			_fight.skill3.removeEventListener(KeyboardEvent.KEY_UP, skillEKeyHandler);
			_fight.skill4.removeEventListener(KeyboardEvent.KEY_UP, skillRKeyHandler);
		}
		
		//收到抽奖信息后关闭战斗界面，弹出抽奖
		private function closeWindowHandler(e:ParamEvent):void
		{
			setTimeout(function temp():void
					   {
						   timeLimit.reset();
						   addPrizeHandler();
					   }, 6000);
			
		}

		
		/**
		state{bomCount剩余雷数，playerid玩家id， state0没开始；1游戏进行中； 2成功； 3失败； 4游戏结束； 5逃跑}
		*/
		private var player0Flag:Boolean = false;
		private var player1Flag:Boolean = false;
		private var player2Flag:Boolean = false;
		private var player3Flag:Boolean = false;
		//更新其他人排雷数量
		private function updateMineNumHandler(e:ParamEvent):void
		{
			var o:Object = e.Param;
			for (var i:int = 0; i < o.state.length; i++)
			{
				_fight["mineNum" + (i + 1)].text = o.state[i].bomCount;
			}
			for(var j:int = 0; j < o.state.length; j++)
			{
				if(o.state[j].state == 1)
				{//游戏进行中
					_fight["otherPlayer" + j].gotoAndStop(1);
				}
				else if(o.state[j].state == 4 || o.state[j].state == 5)
				{//游戏结束或逃跑
					_fight["otherPlayer" + j].gotoAndStop(2);
				}
				else if(o.state[j].state == 3)
				{//游戏失败
					if(this["player" + j + "Flag"] == false)
					{
						this["player" + j +"Flag"] = true;
						_fight["otherPlayer" + j].gotoAndStop(3);
					}
				}
				else if(o.state[j].state == 2)
				{//游戏成功
					_fight["otherPlayer" + j].gotoAndStop(1);
					_fight["otherPlayer" + j].gotoAndStop(4);
				}
			}
		}
		
		//---------------成功插画------------begin
		private var mc:*;
		private function gameSuccessHandler(e:Event):void
		{
			mcShow(1);
		}
		
		private function mcShow(i:int):void
		{
			_fight.reback.mouseEnabled = true;
			mc.gotoAndStop(i);
			mc.x = 460;
			mc.y = 150;
			addChild(mc);
			//setTimeout(function temp():void
//					   {
//						 removeChild(mc);  
//					   }, 2000);
		}
		
		//-------------失败插画----------------begin
		private function gameFailHandler(e:Event):void
		{
			failCloseHandler();
			
		}
		
		

		
		private var boomTime:Timer = new Timer(100);
		private var curStartX:int = 0;
		private var curStartY:int = 0;
		//点雷点炸了
		private function failCloseHandler(e:AlertEvent = null):void
		{
			_fight.reback.mouseEnabled = true;
			
			boomTime.start();
			//boomTimeHandler();
			for(var ii:int = 0; ii < _battleSp.numChildren; ii++)
			{
				if(MineGrid(_battleSp.getChildAt(ii)).getCurMineState() == 4)
				{
					arr.push(_battleSp.getChildAt(ii));
				}
			}
			curStartX = int(curGridName.split("_")[1]);
			curStartY = int(curGridName.split("_")[0]);
			tempTX = curStartX;
			tempTY = curStartY;
			tempBX = curStartX;
			tempBY = curStartY;
			MineGrid(_battleSp.getChildByName(curGridName)).setGridFrame(3);
			MineGrid(_battleSp.getChildByName(curGridName)).setMineNum(10);
		}

		private var tempTX:int = 0;
		private var tempTY:int = 0;
		private var tempBX:int = 0;
		private var tempBY:int = 0;
		private var arr:Array = [];
		private var i:int = 0;
		private function boomTimeHandler(e:TimerEvent = null):void
		{
			for(; i < arr.length;)
			{
				MineGrid(arr[i]).setGridFrame(3);
				MineGrid(arr[i]).setMineNum(10);
				i++;
				
				return;
			}
			setTimeout(function tt():void
					   {
						   mcShow(2);
					   }, 1000);
			
			boomTime.reset();

		}


		//收到消息后显示倒计时30秒， 倒计时结束后开始抽奖------begin---------
		private var timeLimit:Timer = new Timer(50,300);
		private var timeFlag:int = 1;
		//游戏结束倒计时bar开始
		private function invertTimeHandler(e:ParamEvent):void
		{
			_fight.progressBar.visible = true;
			//if(GlobalData.fightInfo.hasEventListener(ParamEvent.GET_RANK))
//				GlobalData.fightInfo.removeEventListener(ParamEvent.GET_RANK, closeWindowHandler);
			timeLimit.start();
		}
			
		private function timeLimitHandler(e:TimerEvent):void
		{
			_fight.progressBar.gotoAndStop(timeFlag++);
			if (timeFlag >= 299)
			{
				 timeLimit.reset();
				setTimeout(function yy():void{
						  addPrizeHandler();
						   }, 2000);
				
			}

		}
		
		//加载抽奖
		private function addPrizeHandler():void
		{
			if(_hasPrize == false)
			{
				_hasPrize = true;
				SetModuleUtils.addMod(ModuleType.REGARD, funRegardHandler);
			}
			
		}
		
		private function funRegardHandler(cl:Class)
		{
			var regard:Regard = new cl() as Regard;
			regard.name = "regard";
			SetModuleUtils.addModule(regard, null, false, false, ModuleType.REGARD);
			SetModuleUtils.removeModule(this, ModuleType.FIGHT);
		}
		//倒计时后抽奖------------------------------------end-------------;


		
		//重新为雷盘赋值
		private function reDrawBattleFieldHandler(e:ParamEvent):void
		{
			var o:Object = e.Param;
			changeBattleFieldGrid(o);
		}

		//改变雷盘显示
		private function changeBattleFieldGrid(o:Object):void
		{
			var col:int = o.col;
			var row:int = o.row;
			var s1:String = o.content.slice(0,col * row);
			var arr:Array = s1.split("");
			var len:int = arr.length;
			var curFrame:int = 0;
			_fight.proText.text = s1;
			for (var i:int = 0; i < len; i++)
			{
				curFrame = SaoLeiTool.changeTurnFrame(arr[i]);
				if (curFrame == 10)
				{//排
					MineGrid(_battleSp.getChildAt(i)).setGridFrame(1);
					MineGrid(_battleSp.getChildAt(i)).setMineState(2);
					MineGrid(_battleSp.getChildAt(i)).check = 1;

				}
				else if (curFrame == 12)
				{//排错
					MineGrid(_battleSp.getChildAt(i)).setGridFrame(1);
					MineGrid(_battleSp.getChildAt(i)).setMineState(4);
					MineGrid(_battleSp.getChildAt(i)).check = 1;
				}
				else if (curFrame == 13)
				{//没排
					MineGrid(_battleSp.getChildAt(i)).setGridFrame(1);
					if(MineGrid(_battleSp.getChildAt(i)).getCurMineState() == 3)
					{
						
					}
					else
					{
						MineGrid(_battleSp.getChildAt(i)).setMineState(1);
					}
					
				}
				else
				{
					//显示数字或空;
					MineGrid(_battleSp.getChildAt(i)).setGridFrame(3);
					MineGrid(_battleSp.getChildAt(i)).setMineNum(curFrame);
					MineGrid(_battleSp.getChildAt(i)).check = 1;
					
					var curGridName:String = _battleSp.getChildAt(i).name;
					//var curGridNum:int = MineGrid(_battleSp.getChildByName(curGridName)).getCurMineNum();//获取当前格子上显示的雷数
					var arr1:Array = [];
					arr1 = curGridName.split("_");
					var temp:String = "";
					if(arr1[0] > 0)
					{
						temp = (arr1[0]-1) + "_" + arr1[1];
						if(MineGrid(_battleSp.getChildByName(temp)).getCurGridFrame() == 1 ||
					    	MineGrid(_battleSp.getChildByName(temp)).getCurGridFrame() == 2)
				  		{
					    	MineGrid(_battleSp.getChildAt(i)).setLeftShapeVisible(true);
						}
					}
					else
					{
						MineGrid(_battleSp.getChildAt(i)).setLeftShapeVisible(true);
						//MineGrid(_battleSp.getChildAt(i)).setTopShapeVisible(true);
					}
					
					if(arr1[1] > 0)
					{
						temp = arr1[0] + "_" + (arr1[1]-1);
						if(MineGrid(_battleSp.getChildByName(temp)).getCurGridFrame() == 1 ||
					   		MineGrid(_battleSp.getChildByName(temp)).getCurGridFrame() == 2)
				  		{
					    	MineGrid(_battleSp.getChildAt(i)).setTopShapeVisible(true);
						}
					}
					else
					{
						//MineGrid(_battleSp.getChildAt(i)).setLeftShapeVisible(true);
						MineGrid(_battleSp.getChildAt(i)).setTopShapeVisible(true);
					}
				}

			}
			
		}

		//{playerid:232, plate:{row:6, col:6, content:abcdefgh},self:{},rival:{}}
		//画雷盘和人物
		private function drawBattleFieldAndDetailsHandler(e:ParamEvent):void
		{
			SetModuleUtils.removeLoading();
			var o:Object = e.Param;
			_roomid = o.teamid;
			selfNum = o.plate.bomCount;
			var po:Object = o.plate;
			_col = po.col;
			_row = po.row;
			var count:int = int(po.row) * int(po.col);
			if (count <= 240)
			{
				_gridSize = 0;
			}
			else
			{
				_gridSize = 1;
			}
			drawGrid(po.row, po.col);
			drawPlayer(o);
		}

		private var _battleSp:Sprite;
		//画雷盘格子及其事件监听------------------------------------------begin
		private function drawGrid(row:int, col:int):void
		{
			_battleSp = new Sprite  ;
			_battleSp = LayMines.layMine("MineGrid",row,col,false,0,0,_gridSize);
			if((_col*_row) == 240)
			{
				_battleSp.x = 33;
				_battleSp.y = 2;
			}
			_fight.battlefield.addChild(_battleSp);
			initGridEvent();
		}
		
		private function setCenterPoint():Point
		{
			var p:Point;
			if(_col == 20 && _row == 12)
			{
				p = new Point(0-(_col/2)*30, 0-(_row/2)*30);
			}
			else if(_col == 30 && _row == 18)
			{
				p = new Point(0-(_col/2)*20, 0-(_row/2)*30);
			}
			return p;
		}

		//初始化雷格监听事件
		private function initGridEvent():void
		{
			for (var i:int = 0; i < _battleSp.numChildren; i++)
			{
				_battleSp.getChildAt(i).addEventListener(GridEvent.DOUBLE_CLICK, gridChangeHandler, false, 1);
				_battleSp.getChildAt(i).addEventListener(GridEvent.LEFT_UP, gridChangeHandler);
				_battleSp.getChildAt(i).addEventListener(GridEvent.RIGHT_MARK, gridChangeHandler);
				_battleSp.getChildAt(i).addEventListener(GridEvent.RIGHT_DISTRUST, gridChangeHandler);
				_battleSp.getChildAt(i).addEventListener(GridEvent.RIGHT_UNDISTRUST, gridChangeHandler);
			}
		}

		//标记雷盘
		private function gridChangeHandler(e:ParamEvent):void
		{

 			var o:Object = new Object  ;
			o.roomId = _roomid;
			o.index = e.currentTarget.index;
			switch (e.type)
			{
				case GridEvent.DOUBLE_CLICK ://双击
					o.key = ClickType.DOUBLE_CLICK;
					
					curGridName = e.currentTarget.name;
					var curGridNum:int = MineGrid(_battleSp.getChildByName(curGridName)).getCurMineNum();//获取当前格子上显示的雷数
					var arr:Array = [];
					arr = curGridName.split("_");
					var gridArr:Array = LayMines.getCurNineGrid(int(arr[0]), int(arr[1]), _col-1, _row-1);//获取当前点击格子的九宫
					var tempFlag:int = 0;
					for(var i:int = 0; i < gridArr.length; i++)
					{
						if(MineGrid(_battleSp.getChildByName(gridArr[i])).getCurMineState() == 2)
						{//插旗
							tempFlag++;
						}
					}
					
					if(tempFlag != curGridNum)
					{
						MineGrid(_battleSp.getChildByName(curGridName)).setMineNum(11, curGridNum);
						return;
					}
					break;
				case GridEvent.LEFT_UP :
					o.key = ClickType.LEFT_CLICK;
					
					curGridName = e.currentTarget.name;
					break;
				case GridEvent.RIGHT_MARK ://标记
					o.key = ClickType.RIGHT_CLICK;
					
					selfNum--;
					_fight.mineNum0.text = selfNum;
					break;
				case GridEvent.RIGHT_DISTRUST ://怀疑
					selfNum++;
					_fight.mineNum0.text = selfNum;
					o.key = ClickType.RIGHT_CLICK;
					break;
				case GridEvent.RIGHT_UNDISTRUST://取消怀疑
					//selfNum++;
					_fight.mineNum0.text = selfNum;
					MineGrid(_battleSp.getChildByName(curGridName)).setMineState(1);
					break;
			}
			
			GlobalData.fightInfo.clearMine(o);
		}
		//画雷盘格子及其事件监听------------------------------------------end;

		
		/**
		 * 画人物信息
		 * [{"playerid":1,"title":"","name":"阿秋","
		 * body":"[{\"idx\":9,\"level\":0,\"classify\":0,\"wear\":5,\"type\":4,\"binder\":1,\"style\":0,\"position\":0,\"inside\":6,\"openid\":440001,\"quantity\":1,\"expired\":0,\"energy\":5,\"lucky\":0,\"dexterity\":25,\"energy1\":0,\"lucky1\":0,\"dexterity1\":0},
		 * {\"idx\":10,\"level\":0,\"classify\":0,\"wear\":5,\"type\":4,\"binder\":1,\"style\":0,\"position\":1,\"inside\":7,\"openid\":440002,\"quantity\":1,\"expired\":0,\"energy\":10,\"lucky\":0,\"dexterity\":10,\"energy1\":0,\"lucky1\":0,\"dexterity1\":0}]",
		 * "sex":2,"avatar":null,"level":1}]
		{"playerid":2,"title":"1","name":"高原","
		 * body":"[]","sex":2,"weapon":"[]","props":"[]","skills":"[]","avatar":null,"level":1,"buffvip":0,"buffenergy":0,"bufflucky":0,"buffdexterity":0,"buffskill":0,"buffexp":0}
		 * @param self:{},rival:{}}
		 * 
		 */
		private function drawPlayer(o:Object):void
		{
			var len:int = o.rival.length;//敌人数量
			playerList = o.rival as Array;
			for (var i:int = 0; i < len; i++)
			{//设置其他玩家位置
				setPlayerSiteFrame(i, 1);
			}
			drawAttItem();//画道具技能格子
			insertPlayerInfo(o.self);//显示个人信息
			for (var j:int = 0; j <= o.rival.length; j++)
			{//设置显示剩余雷数
				_fight["mineNum" + j].text = o.plate.bomCount;
			}
		}
		
		//填充人物数据
		private function insertPlayerInfo(o:Object):void
		{
			
			_fight.playerMC.levelText.text = o.level.toString();
			_fight.playerMC.playerName.text = o.name.toString();
			o.buffervip > 0 ? _fight.playerMC.buffer0.gotoAndStop(2):_fight.playerMC.buffer0.gotoAndStop(1);
			o.bufferexp > 0 ? _fight.playerMC.buffer1.gotoAndStop(2):_fight.playerMC.buffer1.gotoAndStop(1);
			o.bufferenergy > 0 ? _fight.playerMC.buffer2.gotoAndStop(2):_fight.playerMC.buffer2.gotoAndStop(1);
			o.bufferlucky > 0 ? _fight.playerMC.buffer3.gotoAndStop(2):_fight.playerMC.buffer3.gotoAndStop(1);
			o.bufferdexterity > 0 ? _fight.playerMC.buffer4.gotoAndStop(2):_fight.playerMC.buffer4.gotoAndStop(1);
			o.bufferskill > 0 ? _fight.playerMC.buffer5.gotoAndStop(2):_fight.playerMC.buffer5.gotoAndStop(1);
			var oo2:Object = o.weapon;
			var info:BagItemInfo;
			for (var i:int = 0; i < oo2.length; i++)
			{
				if (oo2[i].type == GoodsType.WEAPON)
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

					AttItem(MovieClip(_fight["weaponMC"]).getChildByName("grid")).info = info;
					AttItem(MovieClip(_fight["weaponMC"]).getChildByName("grid")).initBagCell();
					AttItem(MovieClip(_fight["weaponMC"]).getChildByName("grid")).index = 11;
				}
			}

			var propO:Object = o.props;

			for (var j:int = 0; j < propO.length; j++)
			{
				info = new BagItemInfo  ;
				info.binder = propO[j].binder;
				info.itemId = propO[j].idx;
				info.templateId = propO[j].openid;
				info.position = propO[j].position;
				info.number = propO[j].quantity;
				info.type = propO[j].type;
				info.inside = propO[j].inside;
				AttItem(MovieClip(_fight["prop" + (info.inside)].mc).getChildByName("grid")).info = info;
				AttItem(MovieClip(_fight["prop" + info.inside].mc).getChildByName("grid")).initBagCell();
				AttItem(MovieClip(_fight["prop" + (info.inside)].mc).getChildByName("grid")).index = info.inside;
			}

			var skillO:Object = o.skills;
			for (var k:int = 0; k < skillO.length; k++)
			{
				info = new BagItemInfo  ;
				info.itemId = skillO[k].idx;
				info.type = skillO[k].type;
				info.position = skillO[k].position;
				info.inside = skillO[k].inside;
				info.templateId = skillO[k].openid;
				info.level = skillO[k].level;
				info.learn = skillO[k].learn;
				AttItem(MovieClip(_fight["skill" + (info.inside)].mc).getChildByName("grid")).info = info;
				AttItem(MovieClip(_fight["skill" + info.inside].mc).getChildByName("grid")).initBagCell();
				AttItem(MovieClip(_fight["skill" + (info.inside)].mc).getChildByName("grid")).index = info.inside;
			}
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
					_fight["prop" + tempi].mc.addChild(attItem);
					_fight["prop" + tempi].mark.gotoAndStop(tempi);
				}
				else if ((i < 8))
				{
					attItem.itemType = ModuleType.SKILL;
					attItem.infoTextMC.gotoAndStop(14);
					_fight["skill" + (i - 3)].mc.addChild(attItem);
					_fight["skill" + (i - 3)].mark.gotoAndStop(i-3);
				}
				else
				{
					attItem.infoTextMC.gotoAndStop(11);
					_fight["weaponMC"].addChild(attItem);
				}
			}
		}

		/**
		 *初始化界面数据 
		 * @param o
		 * 
		 */
		public function initData(e:ParamEvent):void
		{
			drawBattleFieldAndDetailsHandler(e);
		}

		//设置玩家位置显示信息----------------------------------------------------------begin
		/**
		 *移出其他玩家位置监听 
		 * @param len 其他玩家数量
		 * 
		 */		
		private function removePlayerSiteListener(len:int):void
		{
			for (var i:int = 0; i < len; i++)
			{
				switch (_fight["otherPlayer" + i].currentFrame)
				{
					case 1 ://有人
						removePlayerInStateListener(i);
						break;
					case 2 ://没人
						removeCloseStateListener(i);
						break;
				}
			}
		}
		
		private function removePlayerInStateListener(i:int):void
		{
			
		}
		
		private function removeCloseStateListener(i:int):void
		{
			
		}

		/**
		 *设置其他玩家位置显示状态 
		 * @param index当前设置位
		 * @param value跳转帧
		 */
		private function setPlayerSiteFrame(index:int, value:int):void
		{
			_fight["otherPlayer" + index].gotoAndStop(value);
			if (value == 1)
			{
				addPlayerInStateListener(index);
				setPlayerShowInfo(index, playerList[index]);
			}
			else
			{//人走位空

			}
		}
		
		private function addPlayerInStateListener(i:int):void
		{
			
		}
		
		/**
		 * 设置其他玩家位置显示信息
		 * @param index 当前设置位
		 * @param vo 需要填充的信息
		 * 
		 */		
		private function setPlayerShowInfo(index:int, vo:Object):void
		{

		}		
		
		//关闭
		private function closeHandler(e:MouseEvent):void
		{
			var o:Object = new Object;
			o.message = "是否要退出";
			GlobalData.alertInfo.confirmAlert(o);
			GlobalData.alertInfo.addEventListener(AlertEvent.SUBMIT, submitHandler);
			GlobalData.alertInfo.addEventListener(AlertEvent.CANCEL, cancelHandler);
			
		}
		
		private function submitHandler(e:AlertEvent):void
		{
			_fight.reback.mouseEnabled = false;
			GlobalData.hallInfo.exitRoom(_roomid);
		}
		
		private function cancelHandler(e:AlertEvent):void
		{
			_fight.reback.mouseEnabled = true;
		}
		
		//退出房间成功
		private function exitRoomSuccessHandler(e:ParamEvent):void
		{
			_fight.reback.mouseEnabled = true;
			removeEvent();
			SetModuleUtils.removeModule(this, ModuleType.FIGHT);
		}

		//道具位1点击;
		private function prop1ClickHandler(e:MouseEvent):void
		{

		}

		//道具位2点击
		private function prop2ClickHandler(e:MouseEvent):void
		{

		}


		//道具位3点击
		private function prop3ClickHandler(e:MouseEvent):void
		{

		}

		//道具位4点击
		private function prop4ClickHandler(e:MouseEvent):void
		{

		}

		//技能位Q点击
		private function skillQClickHandler(e:MouseEvent):void
		{

		}

		//技能位W点击
		private function skillWClickHandler(e:MouseEvent):void
		{

		}

		//技能位E点击
		private function skillEClickHandler(e:MouseEvent):void
		{

		}

		//技能位R点击
		private function skillRClickHandler(e:MouseEvent):void
		{

		}

		//道具位1键位操作
		private function prop1KeyHandler(e:KeyboardEvent):void
		{

		}

		//道具位2键位操作
		private function prop2KeyHandler(e:KeyboardEvent):void
		{

		}


		//道具位3键位操作
		private function prop3KeyHandler(e:KeyboardEvent):void
		{

		}

		//道具位4键位操作
		private function prop4KeyHandler(e:KeyboardEvent):void
		{

		}

		//技能位Q键位操作
		private function skillQKeyHandler(e:KeyboardEvent):void
		{

		}

		//技能位W键位操作
		private function skillWKeyHandler(e:KeyboardEvent):void
		{

		}

		//技能位E键位操作
		private function skillEKeyHandler(e:KeyboardEvent):void
		{

		}

		//技能位R键位操作
		private function skillRKeyHandler(e:KeyboardEvent):void
		{

		}


	}
}
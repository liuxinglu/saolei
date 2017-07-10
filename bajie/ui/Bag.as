package bajie.ui
{
	import bajie.constData.CommonConfig;
	import bajie.constData.GoodsType;
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.bag.BagItemInfo;
	import bajie.core.data.fashion.FashionTemplateInfo;
	import bajie.events.BagEvent;
	import bajie.manager.drag.GlobalDragManager;
	import bajie.ui.att.AttItem;
	import bajie.ui.bag.BagItem;
	import bajie.ui.menu.MenuContent;
	import bajie.utils.LayMines;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class Bag extends MovieClip
	{

		private static var _bag:Bag;
		private static var _bagg:*;
		private var _bagSp:Sprite;
		private var curPage:int = 1;
		private var _time:Timer = new Timer(300);

		public static function getInstance():Bag
		{
			if ((_bag == null))
			{
				_bag = new Bag  ;
			}

			return _bag;
		}

		public function Bag()
		{
			// constructor code
			_bagg = GlobalAPI.loaderAPI.getObjectByClassPath("Bags");
			addChild(_bagg);
			initEvent();
			drawAttItem();
			drawBagItem();
		}

		//画人物属性格子
		private function drawAttItem():void
		{
			var attItem:AttItem;
			for (var i:int = 0; i < CommonConfig.BAG_ATT_ITEM_NUM; i++)
			{//
				attItem = new AttItem  ;
				attItem.name = "bag";
				var tempi:int = i + 1;
				attItem.index = tempi;
				attItem.infoTextMC.gotoAndStop(tempi);
				if ((i < 5))
				{
					attItem.itemType = ModuleType.ROLE;
				}
				else if ((i < 10))
				{
					attItem.itemType = ModuleType.FASHION;
				}
				else
				{
					attItem.itemType = ModuleType.ROLE;
				}
				_bagg["bag" + i].addChild(attItem);
			}

			for (var ii:int = 0; ii < CommonConfig.BAG_PROP_ITEM_NUM; ii++)
			{
				attItem = new AttItem  ;
				attItem.name = "prop";
				var tempie:int = ii + 1;
				attItem.index = tempie;
				attItem.itemType = ModuleType.PROP;
				attItem.infoTextMC.gotoAndStop(12);
				_bagg["prop" + ii].addChild(attItem);
			}

			GlobalData.bagInfo.bagPlayerSp = _bagg;
		}

		//填入背包人物角色数据
		private function insertAttItemData(o:Object):void
		{
			for (var j:int = 0; j < CommonConfig.BAG_ATT_ITEM_NUM; j++)
			{

				AttItem(MovieClip(_bagg["bag" + j]).getChildByName("bag")).removeBagCell();
				GlobalDragManager.getInstance().disRegisterDragBox(AttItem(MovieClip(_bagg["bag" + j]).getChildByName("bag")));

			}

			var oo:Object = o.body;//时装
			var oo2:Object = o.weapon;//装备、武器
			var info:BagItemInfo;
			for (var i:int = 0; i < CommonConfig.BAG_ATT_ITEM_NUM; i++)
			{//前五个为装备 后五个为时装 最后一个为武器
				if (i <= 5)
				{
					if (oo2[i] != null || oo2[i] != undefined)
					{//装备、武器
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
						if (oo2[i].type == 2)
						{
							AttItem(MovieClip(_bagg["bag10"]).getChildByName("bag")).info = info;
							AttItem(MovieClip(_bagg["bag10"]).getChildByName("bag")).initBagCell();
							AttItem(MovieClip(_bagg["bag10"]).getChildByName("bag")).index = 11;
						}
						else
						{
							AttItem(MovieClip(_bagg["bag" + (info.inside-1)]).getChildByName("bag")).info = info;
							AttItem(MovieClip(_bagg["bag" + (info.inside - 1)]).getChildByName("bag")).initBagCell();
							AttItem(MovieClip(_bagg["bag" + (info.inside-1)]).getChildByName("bag")).index = info.inside;
						}

					}
				}
				else if (i <= 10)
				{
					if (oo[i - 6] != null || oo[i - 6] != undefined)
					{//时装
						info = new BagItemInfo  ;
						info.binder = oo[i - 6].binder;
						info.itemId = oo[i - 6].idx;
						info.templateId = oo[i - 6].openid;
						info.position = oo[i - 6].position;
						info.number = oo[i - 6].quantity;
						info.type = oo[i - 6].type;
						info.wear = oo[i - 6].wear;
						info.classify = oo[i - 6].classify;
						info.energy = oo[i - 6].energy;
						info.lucky = oo[i - 6].lucky;
						info.dex = oo[i - 6].dexterity;
						info.additEnergy = oo[i - 6].energy1;
						info.additLucky = oo[i - 6].lucky1;
						info.additDex = oo[i - 6].dexterity1;
						info.inside = oo[i - 6].inside;
						var tempInfo:FashionTemplateInfo = GlobalData.fashionTempleteList.getTemplate(info.templateId);
						info.energy = int(tempInfo.energy);
						info.lucky = int(tempInfo.lucky);
						info.dex = int(tempInfo.dexterity);
						info.useLevel = int(tempInfo.useLevel);
						info.skillLevel = int(tempInfo.skillLevel);
						info.skillTemplateId = int(tempInfo.skillTemplateId);
						info.position = int(tempInfo.position);
						AttItem(MovieClip(_bagg["bag" + (info.inside-1)]).getChildByName("bag")).info = info;
						AttItem(MovieClip(_bagg["bag" + (info.inside-1)]).getChildByName("bag")).initBagCell();
						AttItem(MovieClip(_bagg["bag" + (info.inside-1)]).getChildByName("bag")).index = info.inside;
					}
				}


				GlobalDragManager.getInstance().registerDragBox(AttItem(MovieClip(_bagg["bag" + i]).getChildByName("bag")));

			}
		}

		//填入道具;
		private function insertPropItemData(o:Object):void
		{
			for (var j:int = 0; j < CommonConfig.BAG_PROP_ITEM_NUM; j++)
			{

				AttItem(MovieClip(_bagg["prop" + j]).getChildByName("prop")).removeBagCell();
				GlobalDragManager.getInstance().disRegisterDragBox(AttItem(MovieClip(_bagg["prop" + j]).getChildByName("prop")));

			}

			var oo:Object = o.props;
			var info:BagItemInfo;
			for (var i:int = 0; i < CommonConfig.BAG_PROP_ITEM_NUM; i++)
			{
				AttItem(MovieClip(_bagg["prop" + i]).getChildByName("prop")).index = i + 1;
				AttItem(MovieClip(_bagg["prop" + i]).getChildByName("prop")).itemType = ModuleType.PROP;

				if (oo[i] != null || oo[i] != undefined)
				{
					info = new BagItemInfo  ;
					info.binder = oo[i].binder;
					info.itemId = oo[i].idx;
					info.templateId = oo[i].openid;
					info.position = oo[i].position;
					info.number = oo[i].quantity;
					info.type = oo[i].type;
					info.inside = oo[i].inside;
					AttItem(MovieClip(_bagg["prop" + (info.inside-1)]).getChildByName("prop")).info = info;
					AttItem(MovieClip(_bagg["prop" + (info.inside - 1)]).getChildByName("prop")).initBagCell();
					AttItem(MovieClip(_bagg["prop" + (info.inside-1)]).getChildByName("prop")).index = info.inside;
				}
				GlobalDragManager.getInstance().registerDragBox(AttItem(MovieClip(_bagg["prop" + i]).getChildByName("prop")));

			}
		}

		//画背包格子;
		private function drawBagItem():void
		{
			_bagSp = new Sprite  ;
			_bagSp = LayMines.layMine("BagItem",CommonConfig.BAG_ROW_SIZE,CommonConfig.BAG_COL_SIZE,true,1);
			_bagg.itemContainer.addChild(_bagSp);

			for (var j:int = 0; j < _bagSp.numChildren; j++)
			{
				if (_bagSp.getChildAt(j) is MenuContent)
				{
				}
				else
				{
					BagItem(_bagSp.getChildAt(j)).infoTextMC.gotoAndStop(13);
				}


			}

			GlobalData.bagInfo.bagSp = _bagSp;
		}

		//填入背包数据
		private function insertBagItemData(o:Object):void
		{
			var oo:Object = o.items;
			curPage = o.index;
			for (var j:int = 0; j < _bagSp.numChildren; j++)
			{
				if (_bagSp.getChildAt(j) is MenuContent)
				{
				}
				else
				{
					BagItem(_bagSp.getChildAt(j)).removeBagCell();
					GlobalDragManager.getInstance().disRegisterDragBox(_bagSp.getChildAt(j));
				}


			}

			for (var i:int = 0; i < _bagSp.numChildren; i++)
			{
				if (oo[i] != null || oo[i] != undefined)
				{
					var info:BagItemInfo = new BagItemInfo  ;
					//info.binder = oo[i].binder;
					info.itemId = oo[i].idx;
					info.templateId = oo[i].openid;

					if (curPage != 1)
					{
						info.position = oo[i].position;
					}
					else
					{
						info.position = int(oo[i].position) - (curPage - 1) * 42;
					}
					info.curPage = curPage;
					info.number = oo[i].quantity;
					info.type = oo[i].type;
					info.getInfoOrNot = false;
					if(info.type == GoodsType.FLASHION)
					{
						var tempInfo:FashionTemplateInfo = GlobalData.fashionTempleteList.getTemplate(info.templateId);
						info.energy = int(tempInfo.energy);
						info.lucky = int(tempInfo.lucky);
						info.dex = int(tempInfo.dexterity);
						info.useLevel = int(tempInfo.useLevel);
						info.skillLevel = int(tempInfo.skillLevel);
						info.skillTemplateId = int(tempInfo.skillTemplateId);
					}
					
					
					BagItem(_bagSp.getChildAt(info.position)).info = info;
					BagItem(_bagSp.getChildAt(info.position)).initBagCell();

				}
				if (_bagSp.getChildAt(i) is MenuContent)
				{
				}
				else
				{
					BagItem(_bagSp.getChildAt(i)).index = i;
					BagItem(_bagSp.getChildAt(i)).itemType = ModuleType.BAG;
					GlobalDragManager.getInstance().registerDragBox(_bagSp.getChildAt(i));
				}

			}

		}

		public function initEvent():void
		{
			_bagg.closeBtn.addEventListener(MouseEvent.CLICK,closeBtnHandler);
			//道具;
			_bagg.tab0.addEventListener(MouseEvent.CLICK,tab0ClickHandler);
			//装备;
			_bagg.tab1.addEventListener(MouseEvent.CLICK,tab1ClickHandler);
			//时装;
			_bagg.tab2.addEventListener(MouseEvent.CLICK,tab2ClickHandler);

			//翻页
			_bagg.btn1.addEventListener(MouseEvent.CLICK, btn1ClickHandler);
			_bagg.btn2.addEventListener(MouseEvent.CLICK, btn1ClickHandler);
			_bagg.btn3.addEventListener(MouseEvent.CLICK, btn1ClickHandler);
			_bagg.btn4.addEventListener(MouseEvent.CLICK, btn1ClickHandler);
			_bagg.btn5.addEventListener(MouseEvent.CLICK, btn1ClickHandler);

			_bagg.deEnergy.addEventListener(MouseEvent.MOUSE_DOWN, deEnergyClickHandler);
			_bagg.deEnergy.addEventListener(MouseEvent.MOUSE_UP, deEnergyUpHandler);
			_bagg.addEnergy.addEventListener(MouseEvent.MOUSE_DOWN, addEnergyClickHandler);
			_bagg.addEnergy.addEventListener(MouseEvent.MOUSE_UP, deEnergyUpHandler);
			_bagg.deLucky.addEventListener(MouseEvent.MOUSE_DOWN, deLuckyClickHandler);
			_bagg.deLucky.addEventListener(MouseEvent.MOUSE_UP, deEnergyUpHandler);
			_bagg.addLucky.addEventListener(MouseEvent.MOUSE_DOWN, addLuckyClickHandler);
			_bagg.addLucky.addEventListener(MouseEvent.MOUSE_UP, deEnergyUpHandler)
			_bagg.deFlex.addEventListener(MouseEvent.MOUSE_DOWN, deFlexClickHandler);
			_bagg.deFlex.addEventListener(MouseEvent.MOUSE_UP, deEnergyUpHandler);
			_bagg.AddFlex.addEventListener(MouseEvent.MOUSE_DOWN, addFlexClickHandler);
			_bagg.AddFlex.addEventListener(MouseEvent.MOUSE_UP, deEnergyUpHandler);

			_bagg.sure.addEventListener(MouseEvent.CLICK, sureClickHandler);

			_bagg.repairAllMC.addEventListener(MouseEvent.CLICK, repairAllClickHandler);
			_bagg.rebuildBag.addEventListener(MouseEvent.CLICK, rebuildBagClickHandler);

			GlobalData.bagInfo.addEventListener(BagEvent.BAG_PLAYER_INFO,updatePlayerInfoHandler,false,0,true);
			GlobalData.bagInfo.addEventListener(BagEvent.BAG_PROP_INFO,updatePropInfoHandler,false,0,true);
			GlobalData.bagInfo.addEventListener(BagEvent.BAG_EQUIP_INFO,updateEquipInfoHandler,false,0,true);
			GlobalData.bagInfo.addEventListener(BagEvent.BAG_FASHION_INFO,updateFashionInfoHandler,false,0,true);
			
			_time.addEventListener(TimerEvent.TIMER_COMPLETE, timeHandler);
		}
		
		private var _flag:Boolean = false;
		private function timeHandler(e:TimerEvent):void
		{
			_flag = true;
		}
		
		

		//页码按钮
		private function btn1ClickHandler(e:MouseEvent):void
		{
			
			if(e.currentTarget.currentFrame == 2)
			{
				
			}
			else
			{
				//SetModuleUtils.addLoading();
				if (_bagg.bag.currentFrame == 1)
				{//道具
					GlobalData.bagInfo.getBagProp(curPage);
				}
				else if (_bagg.bag.currentFrame == 2)
				{//装备
					GlobalData.bagInfo.getBagEquip(curPage);
				}
				else if (_bagg.bag.currentFrame == 3)
				{//时装
					GlobalData.bagInfo.getBagFashion(curPage);
				}
			}
			
		}

		//_bagg.energyText.text = o.benergy + "+";
//			_bagg.luckyText.text = o.blucky + "+";
//			_bagg.flexText.text = o.bdexterity + "+";
			
		private var _tempEnergy:int;
		private var _tempLucky:int;
		private var _tempDex:int;
		private var _lastPoint:int;
		//减少能量
		private function deEnergyClickHandler(e:MouseEvent):void
		{
			_time.start();
			if(_tempEnergy > GlobalData.playerInfo.userVO.energy)
			{//当能量大于当前实际点数时可以减少
				_flag = false;
				_bagg.energyText.text = --_tempEnergy + "+";
				_bagg.lastAttPoint.text = ++_lastPoint;
			}
		}
		
		private function deEnergyUpHandler(e:MouseEvent):void
		{
			_time.reset();
		}

		//增加能量
		private function addEnergyClickHandler(e:MouseEvent):void
		{
			_time.start();
			if(GlobalData.playerInfo.userVO.energy < _lastPoint)
			{//当能量小于分配点时可以增加
				_flag = false;
				_bagg.energyText.text = ++_tempEnergy + "+";
				_bagg.lastAttPoint.text = --_lastPoint;
			}
		}

		//减少幸运
		private function deLuckyClickHandler(e:MouseEvent):void
		{
			_time.start();
			if(_tempLucky > GlobalData.playerInfo.userVO.lucky)
			{//当幸运大于当前实际点数时可以减少
				_flag = false;
				_bagg.luckyText.text = --_tempLucky + "+";
				_bagg.lastAttPoint.text = ++_lastPoint;
			}
		}

		//增加幸运
		private function addLuckyClickHandler(e:MouseEvent):void
		{
			_time.start();
			if(GlobalData.playerInfo.userVO.lucky < _lastPoint)
			{//当幸运小于分配点时可以增加
				_flag = false;
				_bagg.luckyText.text = ++_tempLucky + "+";
				_bagg.lastAttPoint.text = --_lastPoint;
			}
		}

		//减少灵巧
		private function deFlexClickHandler(e:MouseEvent):void
		{
			_time.start();
			if(_tempDex > GlobalData.playerInfo.userVO.dexterity)
			{//当灵巧大于当前实际点数时可以减少
				_flag = false;
				_bagg.flexText.text = --_tempDex + "+";
				_bagg.lastAttPoint.text = ++_lastPoint;
			}
		}

		//增加灵巧
		private function addFlexClickHandler(e:MouseEvent):void
		{
			_time.start();
			if(GlobalData.playerInfo.userVO.dexterity < _lastPoint)
			{//当灵巧小于分配点时可以增加
				_flag = false;
				_bagg.flexText.text = ++_tempDex + "+";
				_bagg.lastAttPoint.text = --_lastPoint;
			}
		}

		//确定分配点数
		private function sureClickHandler(e:MouseEvent):void
		{
			GlobalData.bagInfo.setAtt(int(_bagg.energyText.text.slice(0, _bagg.energyText.text.length-1)), int(_bagg.luckyText.text.slice(0, _bagg.luckyText.text.length-1)), int(_bagg.flexText.text.slice(0, _bagg.flexText.length-1)), int(_bagg.lastAttPoint.text.slice(0, _bagg.lastAttPoint.text.length)));
		}

		//全部修理
		private function repairAllClickHandler(e:MouseEvent):void
		{
			
		}

		//整理背包
		private function rebuildBagClickHandler(e:MouseEvent):void
		{

		}


		//更新人物格子信息等
		private function updatePlayerInfoHandler(e:BagEvent):void
		{
			SetModuleUtils.removeLoading();
			var o:Object = e.data;
			_bagg.playerMC.levelText.text = o.level;
			_bagg.playerMC.playerName.text = o.name;
			o.buffervip > 0?_bagg.playerMC.buffer0.gotoAndStop(2):_bagg.playerMC.buffer0.gotoAndStop(1);
			o.bufferexp > 0?_bagg.playerMC.buffer1.gotoAndStop(2):_bagg.playerMC.buffer1.gotoAndStop(1);
			o.bufferenergy > 0?_bagg.playerMC.buffer2.gotoAndStop(2):_bagg.playerMC.buffer2.gotoAndStop(1);
			o.bufferlucky > 0?_bagg.playerMC.buffer3.gotoAndStop(2):_bagg.playerMC.buffer3.gotoAndStop(1);
			o.bufferdexterity > 0?_bagg.playerMC.buffer4.gotoAndStop(2):_bagg.playerMC.buffer4.gotoAndStop(1);
			//o.bufferskill > 0?_bagg.playerMC.buffer5.gotoAndStop(2):_bagg.playerMC.buffer5.gotoAndStop(1);
			
			_bagg.exp.expText.text = o.exp+"/"+o.needexp;
			_bagg.lastAttPoint.text = o.markpoints;
			_bagg.energyText.text = o.benergy + "+";
			_bagg.luckyText.text = o.blucky + "+";
			_bagg.flexText.text = o.bdexterity + "+";
			_bagg.energy1Text.text = o.energy;
			_bagg.lucky1Text.text = o.lucky;
			_bagg.flex1Text.text = o.dexterity;
			_bagg.goldText.text = o.gold;
			_bagg.silverText.text = o.silver;
			
			GlobalData.playerInfo.userVO.additDexterity = o.dexterity;
			GlobalData.playerInfo.userVO.additEnergy = o.energy;
			GlobalData.playerInfo.userVO.additLucky = o.lucky;
			GlobalData.playerInfo.userVO.bufferDexterity = o.bufferdexterity;
			GlobalData.playerInfo.userVO.bufferEnergy = o.bufferenergy;
			GlobalData.playerInfo.userVO.bufferExp = o.bufferexp;
			GlobalData.playerInfo.userVO.bufferLucky = o.bufferlucky;
			GlobalData.playerInfo.userVO.bufferSkill = o.bufferskill;
			GlobalData.playerInfo.userVO.bufferVip = o.buffervip;
			GlobalData.playerInfo.userVO.dexterity = o.bdexterity;
			GlobalData.playerInfo.userVO.energy = o.benergy;
			GlobalData.playerInfo.userVO.exp = o.exp;
			GlobalData.playerInfo.userVO.needExp = o.needexp;
			GlobalData.playerInfo.userVO.gold = o.gold;
			GlobalData.playerInfo.userVO.lastPoints = o.markpoints;
			GlobalData.playerInfo.userVO.level = o.level;
			GlobalData.playerInfo.userVO.lucky = o.blucky;
			GlobalData.playerInfo.userVO.sex = o.sex;
			GlobalData.playerInfo.userVO.silver = o.silver;
			GlobalData.playerInfo.userVO.title = o.title;
			
			_lastPoint = o.markpoints;
			_tempEnergy = o.benergy;
			_tempLucky = o.blucky;
			_tempDex = o.bdexterity;
			
			insertPropItemData(o);
			insertAttItemData(o);
		}
		

		//更新背包内道具
		private function updatePropInfoHandler(e:BagEvent):void
		{
			insertBagItemData(e.data);
			//SetModuleUtils.removeLoading();
		}

		//更新背包内装备
		private function updateEquipInfoHandler(e:BagEvent):void
		{
			insertBagItemData(e.data);
			//SetModuleUtils.removeLoading();
		}

		//更新背包内时装
		private function updateFashionInfoHandler(e:BagEvent):void
		{
			insertBagItemData(e.data);
			//SetModuleUtils.removeLoading();
		}

		//道具tab-----------
		private function tab0ClickHandler(e:MouseEvent):void
		{
			_bagg.bag.gotoAndStop(1);
			GlobalData.bagInfo.getBagProp(1);
			//SetModuleUtils.addLoading();
		}

		//装备tab------------;
		private function tab1ClickHandler(e:MouseEvent):void
		{
			_bagg.bag.gotoAndStop(2);
			GlobalData.bagInfo.getBagEquip(1);
			//SetModuleUtils.addLoading();
		}

		//时装tab------------;
		private function tab2ClickHandler(e:MouseEvent):void
		{
			_bagg.bag.gotoAndStop(3);
			GlobalData.bagInfo.getBagFashion(1);
			//SetModuleUtils.addLoading();
		}

		//关闭按钮------------;
		private function closeBtnHandler(e:MouseEvent):void
		{
			removeEvent();
			SetModuleUtils.removeModule(this, ModuleType.BAG);
		}
		private function removeEvent():void
		{
			_bagg.closeBtn.removeEventListener(MouseEvent.CLICK,closeBtnHandler);
			_bagg.tab0.removeEventListener(MouseEvent.CLICK,tab0ClickHandler);
			_bagg.tab1.removeEventListener(MouseEvent.CLICK,tab1ClickHandler);
			_bagg.tab2.removeEventListener(MouseEvent.CLICK,tab2ClickHandler);
			for (var i:int = 0; i < _bagSp.numChildren; i++)
			{
				if (_bagSp.getChildAt(i) is BagItem)
				{
					BagItem(_bagSp.getChildAt(i)).removeEvent();
				}
				else if (_bagSp.getChildAt(i) is MenuContent)
				{
					MenuContent(_bagSp.getChildAt(i)).dispose();
				}
			}
			//翻页;
			_bagg.btn1.removeEventListener(MouseEvent.CLICK, btn1ClickHandler);
			_bagg.btn2.removeEventListener(MouseEvent.CLICK, btn1ClickHandler);
			_bagg.btn3.removeEventListener(MouseEvent.CLICK, btn1ClickHandler);
			_bagg.btn4.removeEventListener(MouseEvent.CLICK, btn1ClickHandler);
			_bagg.btn5.removeEventListener(MouseEvent.CLICK, btn1ClickHandler);

			_bagg.deEnergy.removeEventListener(MouseEvent.MOUSE_DOWN, deEnergyClickHandler);
			_bagg.deEnergy.removeEventListener(MouseEvent.MOUSE_UP, deEnergyUpHandler);
			_bagg.addEnergy.removeEventListener(MouseEvent.MOUSE_DOWN, addEnergyClickHandler);
			_bagg.addEnergy.removeEventListener(MouseEvent.MOUSE_UP, deEnergyUpHandler)
			_bagg.deLucky.removeEventListener(MouseEvent.MOUSE_DOWN, deLuckyClickHandler);
			_bagg.deLucky.removeEventListener(MouseEvent.MOUSE_UP, deEnergyUpHandler);
			_bagg.addLucky.removeEventListener(MouseEvent.CLICK, addLuckyClickHandler);
			_bagg.addLucky.removeEventListener(MouseEvent.MOUSE_UP, deEnergyUpHandler);
			_bagg.deFlex.removeEventListener(MouseEvent.MOUSE_DOWN, deFlexClickHandler);
			_bagg.deFlex.removeEventListener(MouseEvent.MOUSE_UP, deEnergyUpHandler);
			_bagg.AddFlex.removeEventListener(MouseEvent.MOUSE_UP, deEnergyUpHandler);
			_bagg.AddFlex.removeEventListener(MouseEvent.MOUSE_DOWN, addFlexClickHandler);

			_bagg.sure.removeEventListener(MouseEvent.CLICK, sureClickHandler);

			_bagg.repairAllMC.removeEventListener(MouseEvent.CLICK, repairAllClickHandler);
			_bagg.rebuildBag.removeEventListener(MouseEvent.CLICK, rebuildBagClickHandler);

			GlobalData.bagInfo.removeEventListener(BagEvent.BAG_PLAYER_INFO,updatePlayerInfoHandler);
			GlobalData.bagInfo.removeEventListener(BagEvent.BAG_PROP_INFO,updatePropInfoHandler);
			GlobalData.bagInfo.removeEventListener(BagEvent.BAG_EQUIP_INFO,updateEquipInfoHandler);
			GlobalData.bagInfo.removeEventListener(BagEvent.BAG_FASHION_INFO,updateFashionInfoHandler);
			
			_time.removeEventListener(TimerEvent.TIMER_COMPLETE, timeHandler);
		}


	}

}
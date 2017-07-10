package bajie.ui.shop
{
	import bajie.core.data.bag.BagItemInfo;
	import bajie.core.data.fashion.FashionTemplateInfo;
	import flash.display.MovieClip;
	import bajie.core.data.GlobalAPI;
	import bajie.ui.shop.*;
	import flash.events.MouseEvent;
	import bajie.utils.module.SetModuleUtils;
	import bajie.core.data.GlobalData;
	import bajie.events.BagEvent;
	import bajie.constData.ModuleType;
	
	/**
	 * ...
	 * @author azjune
	 */
	public class Shop extends MovieClip
	{
		private var ui:*;
		private var loader:LoaderShopInfo;
		private var type:int = 1;//物品大的分类,1热销,2时装,3消耗品,4银币商店
		private var style:int = 0;//全部0、头部6、脸部7、身体8、装饰9、背景10，全部0、热销1、优惠2，全部0、战斗1、强化2、药剂3、达人专属4
		private var index:int = 1;
		private var total:int = 0;
		
		private var listNum:int = 8;
		private var btnNum:int = 6;
		
		
		public function Shop()
		{
			ui = GlobalAPI.loaderAPI.getObjectByClassPath("shopPan");
			addChild(ui);
			initMC();
			initEvent();
			loader = new LoaderShopInfo();
			loader.loaderListInfo(type.toString(), style.toString(),index.toString(), updateItemList);
			typeState(1);
			styleState(0);
			initPlayerMC();
			GlobalData.mallInfo.getPlayerInfo();
		}
		
		private function initEvent():void {
			GlobalData.bagInfo.addEventListener(BagEvent.BAG_PLAYER_INFO, updatePlayerInfoHandler, false, 0, true);
			ui.btn_close.addEventListener(MouseEvent.CLICK, removeMC);
			
			ui.btn_0.addEventListener(MouseEvent.CLICK, buttonHandler);
			ui.btn_1.addEventListener(MouseEvent.CLICK, buttonHandler);
			ui.btn_2.addEventListener(MouseEvent.CLICK, buttonHandler);
			ui.btn_3.addEventListener(MouseEvent.CLICK, buttonHandler);
			ui.btn_4.addEventListener(MouseEvent.CLICK, buttonHandler);
			ui.btn_5.addEventListener(MouseEvent.CLICK, buttonHandler);
			
			ui.type_1.addEventListener(MouseEvent.CLICK, buttonHandler);
			ui.type_2.addEventListener(MouseEvent.CLICK, buttonHandler);
			ui.type_3.addEventListener(MouseEvent.CLICK, buttonHandler);
			ui.type_4.addEventListener(MouseEvent.CLICK, buttonHandler);
			
			ui.btn_pageDown.addEventListener(MouseEvent.CLICK, pageDownHandler);
			ui.btn_pageUp.addEventListener(MouseEvent.CLICK, pageUpHandler);
		}
		/**
		 * 按钮事件信息
		 * @param	e
		 */
		private function buttonHandler(e:MouseEvent):void {
			switch(e.currentTarget.name) {
				case "type_1":
					typeState(1);
					styleState(0);
					index = 1;
				break;
				case "type_2":
					typeState(2);
					styleState(0);
					index = 1;
				break;
				case "type_3":
					typeState(3);
					styleState(0);
					index = 1;
				break;
				case "type_4":
					typeState(4);
					styleState(0);
					index = 1;
				break;
				case "btn_0":
					styleState(0);
					index = 1;
				break;
				case "btn_1":
					styleState(1);
					index = 1;
				break;
				case "btn_2":
					styleState(2);
					index = 1;
				break;
				case "btn_3":
					styleState(3);
					index = 1;
				break;
				case "btn_4":
					styleState(4);
					index = 1;
				break;
				case "btn_5":
					styleState(5);
					index = 1;
				break;
				default:break;
			}
			if (type == 2&&style != 0) {
				loader.loaderListInfo(type.toString(), (style+5).toString(),index.toString(), updateItemList);
			}else {
				loader.loaderListInfo(type.toString(), style.toString(),index.toString(), updateItemList);
			}
			
		}
		/**
		 * 上翻页
		 * @param	e
		 */
		private function pageUpHandler(e:MouseEvent):void {
			if (index>1) {
				loader.loaderListInfo(type.toString(), style.toString(),(index-1).toString(), updateItemList);
			}
		}
		/**
		 * 下翻页
		 * @param	e
		 */
		private function pageDownHandler(e:MouseEvent):void {
			if (index<total) {
				loader.loaderListInfo(type.toString(), style.toString(),(index+1).toString(), updateItemList);
			}
		}
		private function initMC():void {
			ui.btn_close.buttonMode = true;
			for (var j:int = 0; j < btnNum;j++ ) {
				ui["btn_" + j].txtMC.mouseEnabled = false;
				ui["btn_" + j].buttonMode = true;
			}
			
			for (var i:int = 0; i < listNum;i++ ) {
				var itemList:ShopItemList = new ShopItemList();
				itemList.name = "itemList";
				ui["list_" + i].addChild(itemList);
				ShopItemList(ui["list_" + i].getChildByName("itemList")).visible = false;
			}
		}
		/**
		 * 设置详细分类按钮的信息
		 * @param	value
		 */
		private function typeState(value:int = 1):void {
			ui.pageMC.gotoAndStop(value);
			ui["type_" + value].mouseEnabled = false;
			ui["type_" + type].mouseEnabled = true;
			type = value;
			for (var i:int = 0; i < btnNum;i++) {
				ui["btn_"+i].visible = true;
			}
			ui.btn_0.txtMC.gotoAndStop("quanbu");
			if (value == 1) {
				ui.btn_1.txtMC.gotoAndStop("rexiao");
				ui.btn_2.txtMC.gotoAndStop("youhui");
				ui.btn_3.visible = false;
				ui.btn_4.visible = false;
				ui.btn_5.visible = false;
			}else if (value == 2) {
				ui.btn_1.txtMC.gotoAndStop("toubu");
				ui.btn_2.txtMC.gotoAndStop("lianbu");
				ui.btn_3.txtMC.gotoAndStop("shenti");
				ui.btn_4.txtMC.gotoAndStop("zhuangshi");
				ui.btn_5.txtMC.gotoAndStop("beijing");
			}else if (value == 3) {
				ui.btn_1.txtMC.gotoAndStop("zhandou");
				ui.btn_2.txtMC.gotoAndStop("qianghua");
				ui.btn_3.txtMC.gotoAndStop("yaoji");
				ui.btn_4.txtMC.gotoAndStop("daren");
				ui.btn_5.visible = false;
			}else if (value == 4) {
				ui.btn_1.visible = false;
				ui.btn_2.visible = false;
				ui.btn_3.visible = false;
				ui.btn_4.visible = false;
				ui.btn_5.visible = false;
			}
		}
		private function styleState(value:int):void {
			ui["btn_" + style].gotoAndStop("_up");
			ui["btn_" + style].enabled = true;
			ui["btn_" + style].mouseEnabled = true;
			ui["btn_" + value].mouseEnabled = false;
			ui["btn_" + value].enabled = false;
			ui["btn_" + value].gotoAndStop("onclick");
			style = value;
		}
		
		/**
		 * 更新商城的信息
		 * @param	xml
		 */
		public function updateItemList(xml:XML):void
		{
			index = xml.@index;
			total = xml.@total;
			ui.txt_page.text = xml.@index + "/" + xml.@total;
			
			for (var i:int = 0; i < listNum; i++ ) {
				if (xml.item[i]) {
					ShopItemList(ui["list_" + i].getChildByName("itemList")).visible = true;
					var itemTab:int = (type == 4)?2:1;
					ShopItemList(ui["list_" + i].getChildByName("itemList")).initItemIcon(itemTab,xml.item[i]);
				}else {
					ShopItemList(ui["list_" + i].getChildByName("itemList")).visible = false;
				}
			}
		}
		/////////////////////////////////////////////////////华丽的分割线-以下为人物面板信息////////////////////////////////////////////////////////
		/**
		 * 初始化人物面板元件状态
		 */
		private function initPlayerMC():void {
			var eqiupNumber:int = 11;
			for (var i:int = 0; i < eqiupNumber;i++ ) {
				var _shopItem:ShopItem = new ShopItem();
				ui["bag" + i].addChild(_shopItem);
				_shopItem.infoTextMC.gotoAndStop(i+1);
			}
			var eqiupPropNumber:int = 4;
			for (var j:int = 0; j < eqiupPropNumber;j++ ) {
				var _shopItemProp:ShopItem = new ShopItem();
				ui["prop" + j].addChild(_shopItemProp);
				_shopItemProp.infoTextMC.gotoAndStop(12);
			}
		}
		/**
		 * 更新人物格子信息等
		 * @param	e
		 */
		private function updatePlayerInfoHandler(e:BagEvent):void
		{
			SetModuleUtils.removeLoading();
			var o:Object = e.data;
			//o.buffervip == 0?_bagg.playerMC.buffer0.gotoAndStop(1):_bagg.playerMC.buffer0.gotoAndStop(2);
			//o.bufferexp == 0?_bagg.playerMC.buffer1.gotoAndStop(1):_bagg.playerMC.buffer1.gotoAndStop(2);
			//o.bufferenergy == 0?_bagg.playerMC.buffer2.gotoAndStop(1):_bagg.playerMC.buffer2.gotoAndStop(2);
			//o.bufferlucky == 0?_bagg.playerMC.buffer3.gotoAndStop(1):_bagg.playerMC.buffer3.gotoAndStop(2);
			//o.bufferdexterity == 0?_bagg.playerMC.buffer4.gotoAndStop(1):_bagg.playerMC.buffer4.gotoAndStop(2);
			//o.bufferskill == 0?_bagg.playerMC.buffer5.gotoAndStop(1):_bagg.playerMC.buffer5.gotoAndStop(2);

			
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
			GlobalData.playerInfo.userVO.name = o.name;
			
			var equip:Array = (o.weapon) as Array;
			var fashion:Array = (o.body) as Array;
			var props:Array = (o.props) as Array;
			updatePlayerEqiup(equip);
			updatePlayerFashion(fashion);
			updateEquipProps(props);
			
			updatePlayerState();
		}
		/**
		 * 更新玩家装备信息
		 * @param	arr
		 */
		private function updatePlayerEqiup(arr:Array):void {
			var len:int = arr.length;
			var info:BagItemInfo;
			for (var i:int = 0; i < len;i++ ) {
				info = new BagItemInfo();
				info.binder = arr[i].binder;
				info.itemId = arr[i].idx;
				info.templateId = arr[i].openid;
				info.position = arr[i].position;
				info.number = arr[i].quantity;
				info.type = arr[i].type;
				info.wear = arr[i].wear;
				info.classify = arr[i].classify;
				info.energy = arr[i].energy;
				info.lucky = arr[i].lucky;
				info.dex = arr[i].dexterity;
				info.additEnergy = arr[i].energy1;
				info.additLucky = arr[i].lucky1;
				info.additDex = arr[i].dexterity1;
				info.inside = arr[i].inside;
				if (arr[i].type == 2)
				{
					ShopItem(ui["bag10"].getChildAt(0)).info = info;
					ShopItem(ui["bag10"].getChildAt(0)).initBagCell();
				}
				else
				{
					ShopItem(ui["bag" + (info.inside-1)].getChildAt(0)).info = info;
					ShopItem(ui["bag" + (info.inside-1)].getChildAt(0)).initBagCell();
				}
			}
		}
		/**
		 * 更新玩家时装信息
		 * @param	arr
		 */
		private function updatePlayerFashion(arr:Array):void {
			var len:int = arr.length;
			var info:BagItemInfo;
			var tempInfo:FashionTemplateInfo;
			for (var i:int = 0; i < len;i++ ) {
				info = new BagItemInfo();
				info.binder = arr[i].binder;
				info.itemId = arr[i].idx;
				info.templateId = arr[i].openid;
				info.position = arr[i].position;
				info.number = arr[i].quantity;
				info.type = arr[i].type;
				info.wear = arr[i].wear;
				info.classify = arr[i].classify;
				info.inside = arr[i].inside;
				
				tempInfo = GlobalData.fashionTempleteList.getTemplate(info.templateId);
				info.energy = int(tempInfo.energy);
				info.lucky = int(tempInfo.lucky);
				info.dex = int(tempInfo.dexterity);
				info.skillLevel = int(tempInfo.skillLevel);
				info.skillTemplateId = int(tempInfo.skillTemplateId);
				
				ShopItem(ui["bag" + (info.inside-1)].getChildAt(0)).info = info;
				ShopItem(ui["bag" + (info.inside-1)].getChildAt(0)).initBagCell();
			}
		}
		/**
		 * 更新玩家以装备道具信息
		 */
		private function updateEquipProps(arr:Array):void {
			var len:int = arr.length;
			var info:BagItemInfo;
			for (var i:int = 0; i < len;i++ ) {
				info = new BagItemInfo();
				info.binder = arr[i].binder;
				info.itemId = arr[i].idx;
				info.templateId = arr[i].openid;
				info.position = arr[i].position;
				info.number = arr[i].quantity;
				info.type = arr[i].type;
				info.inside = arr[i].inside;
				
				ShopItem(ui["prop" + (info.inside-1)].getChildAt(0)).info = info;
				ShopItem(ui["prop" + (info.inside-1)].getChildAt(0)).initBagCell();
			}
		}
		private function updatePlayerState():void {
			ui.exp.expText.text = GlobalData.playerInfo.userVO.exp + "/" + GlobalData.playerInfo.userVO.needExp;
			var expState:int = GlobalData.playerInfo.userVO.exp / GlobalData.playerInfo.userVO.needExp * 100;
			ui.exp.gotoAndStop(expState);
			ui.energyText.text = GlobalData.playerInfo.userVO.energy;
			ui.luckyText.text = GlobalData.playerInfo.userVO.lucky;
			ui.flexText.text = GlobalData.playerInfo.userVO.dexterity;
			ui.lastAttPoint.text = GlobalData.playerInfo.userVO.lastPoints;
			ui.playerMC.levelText.text = GlobalData.playerInfo.userVO.level;
			ui.playerMC.playerName.text = GlobalData.playerInfo.userVO.name;
			
			ui.txt_yinbi.text = GlobalData.playerInfo.userVO.silver.toString();
			ui.txt_jinbi.text = GlobalData.playerInfo.userVO.gold.toString();
		}
		/**
		 * 移除组件方法
		 * @param	e
		 */
		private function removeMC(e:MouseEvent = null):void {
			GlobalData.bagInfo.removeEventListener(BagEvent.BAG_PLAYER_INFO, updatePlayerInfoHandler);
			ui.btn_close.removeEventListener(MouseEvent.CLICK, buttonHandler);
			
			ui.btn_1.removeEventListener(MouseEvent.CLICK, buttonHandler);
			ui.btn_2.removeEventListener(MouseEvent.CLICK, buttonHandler);
			ui.btn_3.removeEventListener(MouseEvent.CLICK, buttonHandler);
			ui.btn_4.removeEventListener(MouseEvent.CLICK, buttonHandler);
			ui.btn_5.removeEventListener(MouseEvent.CLICK, buttonHandler);
			ui.btn_0.removeEventListener(MouseEvent.CLICK, buttonHandler);
			
			ui.type_1.removeEventListener(MouseEvent.CLICK, buttonHandler);
			ui.type_2.removeEventListener(MouseEvent.CLICK, buttonHandler);
			ui.type_3.removeEventListener(MouseEvent.CLICK, buttonHandler);
			ui.type_4.removeEventListener(MouseEvent.CLICK, buttonHandler);
			
			ui.btn_pageDown.removeEventListener(MouseEvent.CLICK, buttonHandler);
			ui.btn_pageUp.removeEventListener(MouseEvent.CLICK, buttonHandler);
			
			
			removeChild(ui);
			ui = null;
			loader.removeEvent();
			loader = null;
			SetModuleUtils.removeModule(this, ModuleType.STORE);
		}
	}

}
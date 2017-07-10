package bajie.ui.strengthen 
{
	import bajie.constData.GoodsType;
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.bag.BagItemInfo;
	import bajie.events.ParamEvent;
	import bajie.ui.strengthen.StrengthenItem;
	import bajie.utils.LayMines;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * ...
	 * @author azjune
	 */
	public class Strengthen extends MovieClip 
	{
		private var ui:*;
		private var explain:*;//强化说明
		private var itemSp:Sprite;
		
		private var itemStone_1:StrengthenItem;
		private var itemStone_2:StrengthenItem;
		private var itemStone_3:StrengthenItem;
		private var itemStone_4:StrengthenItem;
		
		public function Strengthen(info:BagItemInfo = null) 
		{
			if (info == null && (info.type != GoodsType.EQUIP || info.type != GoodsType.WEAPON)) {
				SetModuleUtils.removeModule(this, ModuleType.STRENGTHEN);
				return;
			}
			
			ui = GlobalAPI.loaderAPI.getObjectByClassPath("strengthenPan");
			addChild(ui);
			
			initEvent();
			initMCState();
			drawItem();
			initStoneInfo();
			
			itemStone_1.info = info;
			
			GlobalData.strengthenInfo.getUpgradeInfo(itemStone_1.info.itemId, itemStone_1.info.curPage);
		}
		/**
		 * 重置使用宝石数量
		 */
		private function initStoneInfo():void {
			GlobalData.strengthenInfo.strengthenType = 0;
			GlobalData.strengthenInfo.useLucky = 0;
			GlobalData.strengthenInfo.totalLucky = 0;
			GlobalData.strengthenInfo.useExplosion = 0;
			GlobalData.strengthenInfo.totalExplosion = 0;
			GlobalData.strengthenInfo.useStone = 0;
			GlobalData.strengthenInfo.mustStone = 0;
			GlobalData.strengthenInfo.totalStone = 0;
		}
		/**
		 * 初始化监听事件方法
		 */
		private function initEvent():void {
			GlobalData.strengthenInfo.addEventListener(ParamEvent.GET_UPDATE_MATERIAL, insertBagItemData);
			GlobalData.strengthenInfo.addEventListener(ParamEvent.GET_UPDATE_INFO, insertInfo);
			ui.btn_close.addEventListener(MouseEvent.CLICK, clickHandler);
			ui.btn_strengthen.addEventListener(MouseEvent.CLICK, clickHandler);
			ui.btn_gift.addEventListener(MouseEvent.CLICK, clickHandler);
			ui.btn_explain.addEventListener(MouseEvent.CLICK, clickHandler);
			
			GlobalData.strengthenInfo.addEventListener("updateStrengthenItem", updateStrengthenItem);
		}
		private function initMCState():void {
			ui.btn_close.buttonMode = true;
			ui.btn_strengthen.buttonMode = true;
			
			ui.btn_strengthen.gotoAndStop("non");
			ui.btn_strengthen.mouseEnabled = false;
			ui.btn_strengthen.buttonMode = false;
		}
		/**
		 * 更新按钮信息
		 */
		private function updateBtnState():void {
			if (GlobalData.strengthenInfo.mustStone == GlobalData.strengthenInfo.useStone) {
				ui.btn_strengthen.gotoAndStop("_up");
				ui.btn_strengthen.mouseEnabled = true;
				ui.btn_strengthen.buttonMode = true;
			}else {
				ui.btn_strengthen.gotoAndStop("non");
				ui.btn_strengthen.mouseEnabled = false;
				ui.btn_strengthen.buttonMode = false;
			}
		}
		/**
		 * 按钮点击事件方法
		 * @param	e
		 */
		private function clickHandler(e:MouseEvent):void {
			switch(e.currentTarget.name) {
				case "btn_close":
					removeMC();
				break;
				case "btn_strengthen":
					GlobalData.strengthenInfo.upgradeLevel(itemStone_1.info.itemId, GlobalData.strengthenInfo.useLucky, GlobalData.strengthenInfo.useExplosion, itemStone_1.info.curPage);
					removeMC();
				break;
				case "btn_gift":
					//强化礼包
				break;
				case "btn_explain":
					explain = GlobalAPI.loaderAPI.getObjectByClassPath("strengthenExplain");
					SetModuleUtils.addModule(explain, null, false, false, ModuleType.STR_EXPLAIN);
					explain.btn_close.buttonMode = true;
					explain.btn_close.addEventListener(MouseEvent.CLICK,closeExplain);
				break;
				default:break;
			}
		}
		/**
		 * 绘制道具格子
		 */
		private function drawItem():void
		{
			itemSp = new Sprite();
			itemSp = LayMines.layMine("StrengthenItem", 2, 6);
			itemSp.x = 42;
			itemSp.y = 387;
			ui.addChild(itemSp);
			
			itemStone_1 = new StrengthenItem(1);
			itemStone_2 = new StrengthenItem(2);
			itemStone_3 = new StrengthenItem(3);
			itemStone_4 = new StrengthenItem(4);
			
			ui.item_1.addChild(itemStone_1);
			
			ui.item_2.addChild(itemStone_2);
			ui.item_3.addChild(itemStone_3);
			ui.item_4.addChild(itemStone_4);
		}
		private function insertInfo(e:ParamEvent):void {
			var o:Object = e.Param;
			ui.txt_jinbi.text = o.gold;
			ui.txt_yinbi.text = o.silver;
			ui.txt_useYinbi.text = o.spend;
			
			GlobalData.strengthenInfo.mustStone = o.stone;
			
			if (o.classify == 1) {
				ui.txt_shuXing.text = "能量+";
				ui.txt_shuXingQian.text = itemStone_1.info.additEnergy;
				ui.txt_shuXingHou.text = o.energy;
			}else if (o.classify == 2){
				ui.txt_shuXing.text = "幸运+";
				ui.txt_shuXingQian.text = itemStone_1.info.additLucky;
				ui.txt_shuXingHou.text = o.lucky;
			}else if (o.classify == 3) {
				ui.txt_shuXing.text = "灵巧+";
				ui.txt_shuXingQian.text = itemStone_1.info.additDex;
				ui.txt_shuXingHou.text = o.dexterity;
			}
			
			GlobalData.strengthenInfo.strengthenType = o.type;
			
			itemStone_1.initItemPic();
		}
		/**
		 * 填充格子数据
		 * @param	o
		 */
		private function insertBagItemData(e:ParamEvent):void
		{
			var o:Object = e.Param;
			ui.txt_page.text = o.index + "/" + o.maxbackpack;
			 
			var oo:Array = (o.items) as Array;
			for(var i:int = 0; i < itemSp.numChildren; i++)
			{
				if(oo[i] != null || oo[i] != undefined)
				{
					var info:BagItemInfo = new BagItemInfo;
					info.binder = oo[i].binder;
					info.itemId = oo[i].idx;
					info.templateId = oo[i].openid;
					info.position = oo[i].position;
					info.number = oo[i].quantity;
					info.type = oo[i].type;
					StrengthenItem(itemSp.getChildAt(i)).info = info;
					StrengthenItem(itemSp.getChildAt(i)).dragEnable = true;
					StrengthenItem(itemSp.getChildAt(i)).initItemPic();
					if (GlobalData.strengthenInfo.strengthenType == GoodsType.EQUIP) {
						if (info.templateId == GoodsType.EQIUP_STONE) {
							GlobalData.strengthenInfo.totalStone = info.number;
						}
					}else if (GlobalData.strengthenInfo.strengthenType == GoodsType.WEAPON) {
						if (info.templateId == GoodsType.WEAPON_STONE) {
							GlobalData.strengthenInfo.totalStone = info.number;
						}
					}
					if (info.templateId == GoodsType.LUCKY_STONE) {
						GlobalData.strengthenInfo.totalLucky = info.number;
					}
					if (info.templateId == GoodsType.EXPLOSION_STONE) {
						GlobalData.strengthenInfo.totalExplosion = info.number;
					}
					
				}
				else
				{
					break;
				}
			}
		}
		/**
		 * 更新使用宝石的方法
		 * @param	e
		 */
		private function updateStrengthenItem(e:Event):void {
			var info:BagItemInfo;
			if (GlobalData.strengthenInfo.useStone > 0) {
				info = new BagItemInfo();
				if (GlobalData.strengthenInfo.strengthenType == GoodsType.EQUIP) {
					info.templateId = GoodsType.EQIUP_STONE;
				}else if (GlobalData.strengthenInfo.strengthenType == GoodsType.WEAPON) {
					info.templateId = GoodsType.WEAPON_STONE;
				}
				info.number = GlobalData.strengthenInfo.useStone;
				info.type = GoodsType.PROP;
				itemStone_2.info = info;
			}else {
				if (itemStone_2) {
					itemStone_2.info = null;
				}
			}
			if (GlobalData.strengthenInfo.useLucky > 0) {
				info = new BagItemInfo();
				info.templateId = GoodsType.LUCKY_STONE;
				info.number = GlobalData.strengthenInfo.useLucky;
				info.type = GoodsType.PROP;
				itemStone_3.info = info;
			}else {
				if (itemStone_3) {
					itemStone_3.info = null;
				}
			}
			if (GlobalData.strengthenInfo.useExplosion > 0) {
				info = new BagItemInfo();
				info.templateId = GoodsType.EXPLOSION_STONE;
				info.number = GlobalData.strengthenInfo.useExplosion;
				info.type = GoodsType.PROP;
				itemStone_4.info = info;
			}else {
				if (itemStone_4) {
					itemStone_4.info = null;
				}
			}
			itemStone_2.initItemPic();
			itemStone_3.initItemPic();
			itemStone_4.initItemPic();
			
			updateBtnState();
		}
		/**
		 * 移除组件方法
		 * @param	e
		 */
		private function removeMC(e:Event = null):void {
			GlobalData.strengthenInfo.removeEventListener(ParamEvent.GET_UPDATE_MATERIAL, insertBagItemData);
			GlobalData.strengthenInfo.removeEventListener(ParamEvent.GET_UPDATE_INFO, insertInfo);
			ui.btn_close.removeEventListener(MouseEvent.CLICK, clickHandler);
			ui.btn_strengthen.removeEventListener(MouseEvent.CLICK, clickHandler);
			ui.btn_gift.removeEventListener(MouseEvent.CLICK, clickHandler);
			ui.btn_explain.removeEventListener(MouseEvent.CLICK, clickHandler);
			
			GlobalData.strengthenInfo.removeEventListener("updateStrengthenItem", updateStrengthenItem);
			
			itemStone_1.removeEvent();
			itemStone_2.removeEvent();
			itemStone_3.removeEvent();
			itemStone_4.removeEvent();
			
			itemStone_1 = null;
			itemStone_2 = null;
			itemStone_3 = null;
			itemStone_4 = null;
			
			for (var i:int = 0; i < itemSp.numChildren; i++)
			{
				if (itemSp.getChildAt(i) is StrengthenItem)
				{
					StrengthenItem(itemSp.getChildAt(i)).removeEvent();
				}
			}
			
			itemSp = null;
			SetModuleUtils.removeModule(this, ModuleType.STRENGTHEN);
		}
		/**
		 * 关闭强化说明
		 * @param	e
		 */
		private function closeExplain(e:MouseEvent):void {
			SetModuleUtils.removeModule(explain, ModuleType.STR_EXPLAIN);
		}
	}

}
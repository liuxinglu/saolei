package bajie.ui.shop 
{
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.ui.shop.LoaderShopInfo;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;

	/**
	 * ...
	 * @author azjune
	 */
	public class ShopBuyItem extends MovieClip 
	{
		private var ui:*;
		private var _item:ShopItem;
		private var curCheck:int = 1;
		private var _type:int;//1购买道具2赠送道具
		private var loader:LoaderShopInfo;
		private var _buyType:int;//1金币2银币
		
		private var price:Array = [];
		private var curPrice:int = 0;

		public function ShopBuyItem(type:int,item:ShopItem,buytype:int) 
		{
			ui = GlobalAPI.loaderAPI.getObjectByClassPath("buyItemPan");
			addChild(ui);
			
			_type = type;
			if (_type == 1) {
				ui.sendName.visible = false;
			}else {
				ui.sendName.visible = true;
			}
			ui.title.gotoAndStop(_type);
			
			_item = new ShopItem();
			_item.info = item.info;
			_item.infoTextMC.gotoAndStop(13);
			_item.initBagCell();
			_item.x = 50;
			_item.y = 79;
			ui.addChild(_item);
			
			//购买方式，1金币2银币
			_buyType = buytype;
			ui.goldMC_1.gotoAndStop(_buyType);
			ui.goldMC_2.gotoAndStop(_buyType);
			ui.goldMC_3.gotoAndStop(_buyType);
			
			ui.btn_submit.buttonMode = true;
			ui.btn_submit.btnTxt.gotoAndStop(1);
			ui.btn_submit.btnTxt.mouseEnabled = false;
			ui.btn_cancel.buttonMode = true;
			ui.btn_cancel.btnTxt.gotoAndStop(2);
			ui.btn_cancel.btnTxt.mouseEnabled = false;
			
			ui.txt_name.text = _item.info.template.name;
			
			loader = new LoaderShopInfo();
			loader.loaderItemInfo(_item.info.itemId.toString(), updateInfo);
			
			initEvent();
		}
		private function updateInfo(xml:XML):void {
			for (var i:int = 0; i < 3;i++ ) {
				if (xml.item[i]) {
					if (_buyType == 1) {
						ui["txt_price_" + (i + 1)].text = xml.item[i].@gold;
					}else {
						ui["txt_price_" + (i + 1)].text = xml.item[i].@silver;
					}
					ui["txt_num_" + (i + 1)].text = xml.item[i].@unit;
					price.push(xml.item[i].@idx);
				}
			}
			checkBox(1);
		}
		private function initEvent():void {
			ui.checkBox_1.addEventListener(MouseEvent.CLICK, buttonHandler);
			ui.checkBox_2.addEventListener(MouseEvent.CLICK, buttonHandler);
			ui.checkBox_3.addEventListener(MouseEvent.CLICK, buttonHandler);
			
			ui.btn_submit.addEventListener(MouseEvent.CLICK, buttonHandler);
			ui.btn_cancel.addEventListener(MouseEvent.CLICK, buttonHandler);
			ui.btn_close.addEventListener(MouseEvent.CLICK, buttonHandler);
			
			ui.sendName.txt_name.addEventListener(FocusEvent.FOCUS_IN, changgeTxt);
			ui.sendName.txt_name.addEventListener(FocusEvent.FOCUS_OUT, changgeOutTxt);
		}
		private function buttonHandler(e:MouseEvent):void {
			switch(e.currentTarget.name) {
				case "checkBox_1":
					checkBox(1);
				break;
				case "checkBox_2":
					checkBox(2);
				break;
				case "checkBox_3":
					checkBox(3);
				break;
				case "btn_submit":
					if (_type==1) {
						if (_buyType==1) {
							GlobalData.mallInfo.shopBuyGold(curPrice);
						}else {
							GlobalData.mallInfo.shopBuySilver(curPrice);
						}
					}else {
						if (ui.sendName.txt_name.text == "请输入对方的ID或昵称"||ui.sendName.txt_name.text == "") {
							//请输入用户名或id
						}else {
							//发送赠送道具信息
						}
					}
					removeMC();
				break;
				case "btn_cancel":
					removeMC();
				break;
				case "btn_close":
					removeMC();
				break;
				default:break;
			}
		}
		private function removeMC():void {
			ui.checkBox_1.removeEventListener(MouseEvent.CLICK, buttonHandler);
			ui.checkBox_2.removeEventListener(MouseEvent.CLICK, buttonHandler);
			ui.checkBox_3.removeEventListener(MouseEvent.CLICK, buttonHandler);
			
			ui.btn_submit.removeEventListener(MouseEvent.CLICK, buttonHandler);
			ui.btn_cancel.removeEventListener(MouseEvent.CLICK, buttonHandler);
			
			ui.sendName.txt_name.removeEventListener(FocusEvent.FOCUS_IN, changgeTxt);
			ui.sendName.txt_name.removeEventListener(FocusEvent.FOCUS_OUT, changgeOutTxt);
			
			price = null;
			
			loader = null;
			ui.removeChild(_item);
			_item = null;
			removeChild(ui);
			ui = null;
			
			SetModuleUtils.removeModule(this, ModuleType.SHOP_ITEM);
		}
		private function checkBox(value:int):void {
			ui["checkBox_" + curCheck].mouseEnabled = true;
			ui["checkBox_" + curCheck].enabled = true;
			ui["checkBox_" + curCheck].right.visible = false;
			
			ui["checkBox_" + value].mouseEnabled = false;
			ui["checkBox_" + value].enabled = false;
			ui["checkBox_" + value].right.visible = true;
			curCheck = value;
			
			curPrice = price[value-1];
		}
		private function changgeTxt(e:FocusEvent):void {
			if (ui.sendName.txt_name.text == "请输入对方的ID或昵称") {
				ui.sendName.txt_name.text = "";
				ui.sendName.txt_name.textColor = 0xffff00;
			}
		}
		private function changgeOutTxt(e:FocusEvent):void {
			if (ui.sendName.txt_name.text == "") {
				ui.sendName.txt_name.text = "请输入对方的ID或昵称";
				ui.sendName.txt_name.textColor = 0x8c7100;
			}
		}
	}

}
package bajie.ui.shop
{
	import bajie.constData.GoodsType;
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.bag.BagItemInfo;
	import bajie.core.data.fashion.FashionTemplateInfo;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author azjune
	 */
	public class ShopItemList extends MovieClip
	{
		private var hot:int;
		private var newly:int;
		private var discount:int;
		private var MC:*
		public var item:ShopItem;
		
		private var buyTab:int;//1金币2银币
		
		public function ShopItemList()
		{
			MC = GlobalAPI.loaderAPI.getObjectByClassPath("itemList");
			addChild(MC);
			
			item = new ShopItem();
			addChild(item);
			item.x = item.y = 8;
			item.infoTextMC.gotoAndStop(13);
			
			initEvent();
		}
		
		public function initItemIcon(itemTab:int, xml:XML):void
		{
			//type="1" openid="110002" gold="2" silver="100" hot="1" newly="0" discount="0" price="<br />1个：2金币<br />10个：18金币<br />50个：80金币" kind="2"
			buyTab = itemTab;
			
			item.info = new BagItemInfo();
			
			if (buyTab == 1)
			{
				MC.txt_gold.text = xml.@gold.toString();
				MC.goldMC.gotoAndStop(1);
			}
			else
			{
				MC.txt_gold.text = xml.@silver.toString();
				MC.goldMC.gotoAndStop(2);
			}
			item.info.templateId = xml.@openid;
			item.info.type = xml.@type;
			item.info.itemId = xml.@kind;
			hot = xml.@hot;
			newly = xml.@newly;
			discount = xml.@discount;
			if (item.info.template) {
				MC.txt_name.text = item.info.template.name;
			}else {
				this.visible = false;
			}
			
			try
			{
				if (item.info.type == GoodsType.FLASHION)
				{
					var fashionInfo:FashionTemplateInfo = GlobalData.fashionTempleteList.getTemplate(int(xml.@openid));
					item.info.useLevel = int(fashionInfo.useLevel);
					item.info.energy = int(fashionInfo.energy);
					item.info.lucky = int(fashionInfo.lucky);
					item.info.dex = int(fashionInfo.dexterity);
					item.info.skillLevel = int(fashionInfo.skillLevel);
					item.info.skillTemplateId = int(fashionInfo.skillTemplateId);
					item.info.position = int(fashionInfo.position);
				}
			}
			catch (err:Error)
			{
				trace("设置格子信息失败:" + err);
			}
			item.initBagCell();
			
			MC.btn_buy.buttonMode = true;
			if (buyTab != 1)
			{
				MC.btn_send.buttonMode = false;
				MC.btn_send.enabled = false;
				MC.btn_send.mouseEnabled = false;
				MC.btn_send.gotoAndStop("non");
			}
			else
			{
				MC.btn_send.buttonMode = true;
				MC.btn_send.enabled = true;
				MC.btn_send.mouseEnabled = true;
				MC.btn_send.gotoAndStop("_up");
			}
		
		}
		
		private function initEvent():void
		{
			MC.btn_buy.addEventListener(MouseEvent.CLICK, buyItem);
			MC.btn_send.addEventListener(MouseEvent.CLICK, buyItem);
		}
		
		private function buyItem(e:MouseEvent):void
		{
			var type:int = (e.currentTarget.name == "btn_buy")?1:2;
			var buyPan:ShopBuyItem = new ShopBuyItem(type, item, buyTab);
			SetModuleUtils.addModule(buyPan, null, false, false, ModuleType.SHOP_ITEM);
		}
		
		public function removeMC():void
		{
			MC.btn_buy.removeEventListener(MouseEvent.CLICK, buyItem);
			MC.btn_send.removeEventListener(MouseEvent.CLICK, buyItem);
			item.removeEvent();
			removeChild(item);
			item = null;
		}
	}

}
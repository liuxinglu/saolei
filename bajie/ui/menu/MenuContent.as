package bajie.ui.menu {
	import bajie.constData.GoodsType;
	import bajie.constData.ModuleType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.bag.BagItemInfo;
	import bajie.events.BajieDispatcher;
	import bajie.events.MenuEvent;
	import bajie.interfaces.dispose.IDispose;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import bajie.ui.bag.BagItem;
	import bajie.ui.base.item.BaseItem;
	
	public class MenuContent extends MovieClip{

		public var info:BagItemInfo = new BagItemInfo;
		public function MenuContent() {
			// constructor code
			
		}
		
		public function initEvent():void
		{
			GlobalAPI.sp.addEventListener(MouseEvent.CLICK, stageClickHandler);
			BajieDispatcher.getInstance().addEventListener(MenuEvent.MENU_USE, useHandler);
			BajieDispatcher.getInstance().addEventListener(MenuEvent.MENU_SALE, saleHandler);
			BajieDispatcher.getInstance().addEventListener(MenuEvent.MENU_ENHANCE, enhanceHandler);
			BajieDispatcher.getInstance().addEventListener(MenuEvent.MENU_MOVE, moveHandler);
			BajieDispatcher.getInstance().addEventListener(MenuEvent.MENU_REPAIR, repairHandler);
			BajieDispatcher.getInstance().addEventListener(MenuEvent.MENU_UNSNACH, unsnachHandler);
		}
		
		private function stageClickHandler(e:MouseEvent):void
		{
			try{
				
				if(e.target.parent is BaseItem)
				{
					trace("adf");
					//dispose();
				}
				else
				{
					dispose();
				}
				
			}
			catch(er:Error)
			{
				trace(er.message);
				//dispose();
			}
			//e.stopImmediatePropagation();
		}
		
		//使用、装备
		private function useHandler(e:MenuEvent):void
		{
			if(info.type == GoodsType.EQUIP || info.type == GoodsType.WEAPON)
				GlobalData.bagInfo.equipEquip(info.itemId);
			else if(info.type == GoodsType.PROP)
				GlobalData.bagInfo.equipProp(info.itemId);
			else if(info.type == GoodsType.FLASHION)
				GlobalData.bagInfo.equipFashion(info.itemId);
			
			dispose();
			e.stopImmediatePropagation();
		}
		
		//售出
		private function saleHandler(e:MenuEvent):void
		{
			
			dispose();
			e.stopImmediatePropagation();
		}
		
		//强化
		private function enhanceHandler(e:MenuEvent):void
		{
			if(info.type == GoodsType.EQUIP || info.type == GoodsType.WEAPON)
			{
				GlobalData.strengthenInfo.enterStrengthen(info);
			}
			
			dispose();
			e.stopImmediatePropagation();
		}
		
		//移动
		private function moveHandler(e:MenuEvent):void
		{
			
			dispose();
			e.stopImmediatePropagation();
		}
		
		//修理
		private function repairHandler(e:MenuEvent):void
		{
			
			dispose();
			e.stopImmediatePropagation();
		}
		
		//卸下
		private function unsnachHandler(e:MenuEvent):void
		{
			if(info.type == GoodsType.EQUIP || info.type == GoodsType.WEAPON)
			{
				GlobalData.bagInfo.unsnachEquip(info.itemId);
			}
			else if(info.type == GoodsType.PROP)
			{
				GlobalData.bagInfo.unsnachProp(info.itemId);
			}
			else if(info.type == GoodsType.FLASHION)
			{
				GlobalData.bagInfo.unsnachFashion(info.itemId);
			}
			
			dispose();
			e.stopImmediatePropagation();
		}
		
		public function dispose():void
		{
			removeEvent();
			SetModuleUtils.removeModule(this, ModuleType.MENU);
		}
		
		private function removeEvent():void
		{
			GlobalAPI.sp.removeEventListener(MouseEvent.CLICK, stageClickHandler);
			BajieDispatcher.getInstance().removeEventListener(MenuEvent.MENU_USE, useHandler);
			BajieDispatcher.getInstance().removeEventListener(MenuEvent.MENU_SALE, saleHandler);
			BajieDispatcher.getInstance().removeEventListener(MenuEvent.MENU_ENHANCE, enhanceHandler);
			BajieDispatcher.getInstance().removeEventListener(MenuEvent.MENU_MOVE, moveHandler);
			BajieDispatcher.getInstance().removeEventListener(MenuEvent.MENU_REPAIR, repairHandler);
			BajieDispatcher.getInstance().removeEventListener(MenuEvent.MENU_UNSNACH, unsnachHandler);
		}

}
	
}

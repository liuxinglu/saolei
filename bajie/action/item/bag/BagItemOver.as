package bajie.action.item.bag 
{
	import bajie.constData.GoodsType;
	import bajie.core.data.GlobalData;
	import bajie.core.data.bag.BagInfo;
	import bajie.core.data.bag.BagItemInfo;
	import bajie.events.BajieDispatcher;
	import bajie.events.ItemEvent;
	import bajie.interfaces.item.IMouseOver;
	import bajie.manager.tick.ToolTipManager;
	import bajie.ui.bag.BagItem;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BevelFilter;
	import flash.filters.GlowFilter;
	
	public class BagItemOver implements IMouseOver 
	{
		private var _e:ItemEvent;
		private var _info:BagItemInfo;
		public function BagItemOver(info:BagItemInfo) 
		{
			// constructor code
			_info = info;
		}
		
		public function itemMouseOver(e:ItemEvent):void
		{
			_e = e;
			var o:Object = e.Param;
			var filter:BevelFilter = new BevelFilter();
			var glow:GlowFilter = new GlowFilter();
			glow.inner = false;
			glow.color = 0x00CC66;
			filter.distance = 0;
			var arrayFilter:Array = [filter, glow];
			e.Param.currentTarget.filters = arrayFilter;
			if(_info != null)
			{
				if(_info.type == GoodsType.WEAPON || _info.type == GoodsType.EQUIP)
				{//武器装备
					if(_info.getInfoOrNot == false)
					{
						GlobalData.bagInfo.addEventListener(ItemEvent.ITEM_INFO, showTip);
						GlobalData.bagInfo.getEquipDetail(_info.itemId);
					}
					else
					{
						ToolTipManager.getInstance().show(e.Param.currentTarget as DisplayObject, _info);
					}
				}
				else
				{
					ToolTipManager.getInstance().show(e.Param.currentTarget as DisplayObject, _info);
				}
			}
		}
		
		private function showTip(e:ItemEvent):void
		{
			GlobalData.bagInfo.removeEventListener(ItemEvent.ITEM_INFO, showTip);
			
			var o:Object = e.Param;
			BagItem(GlobalData.bagInfo.bagSp.getChildAt(_info.position)).info.getInfoOrNot = true; 
			ToolTipManager.getInstance().show(_e.Param.target.parent as DisplayObject, _info);
		}

	}
	
}

package bajie.action.item.att {
	import bajie.core.data.GlobalData;
	import bajie.core.data.bag.BagItemInfo;
	import bajie.events.ItemEvent;
	import bajie.interfaces.item.IMouseOver;
	import bajie.manager.tick.ToolTipManager;
	import bajie.ui.att.AttItem;
	
	import flash.display.DisplayObject;
	import flash.filters.BevelFilter;
	import flash.filters.GlowFilter;
	import bajie.constData.GoodsType;
	import flash.display.MovieClip;
	
	public class AttItemOver implements IMouseOver {
		private var _e:ItemEvent;
		private var _info:BagItemInfo;
		public function AttItemOver(info:BagItemInfo) {
			// constructor code
			_info = info;
		}
		
		public function itemMouseOver(e:ItemEvent):void
		{
			_e = e;
			var o:Object = e.Param;
			if(_info != null)
			{
				if(_info.type == GoodsType.WEAPON || _info.type == GoodsType.EQUIP)
				{
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
					ToolTipManager.getInstance().show(e.Param.currentTarget as DisplayObject,_info);
				}
			}
			
		}
		
		private function showTip(e:ItemEvent):void
		{
			GlobalData.bagInfo.removeEventListener(ItemEvent.ITEM_INFO, showTip);
			var o:Object = e.Param;
			var mc:MovieClip = GlobalData.bagInfo.bagPlayerSp["bag" + (_info.inside-1)];
			AttItem(mc.getChildByName("bag")).info.getInfoOrNot = true;
			ToolTipManager.getInstance().show(_e.Param.target.parent as DisplayObject, _info);
		}

	}
	
}

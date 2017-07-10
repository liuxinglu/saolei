package bajie.action.item.shop 
{
	import bajie.core.data.bag.BagItemInfo;
	import bajie.interfaces.item.IMouseOver;
	import flash.events.MouseEvent;
	import bajie.events.ItemEvent;
	import bajie.manager.tick.ToolTipManager;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import bajie.core.data.GlobalData;
	import bajie.events.ParamEvent;
	import bajie.constData.GoodsType;
	
	public class ShopOver implements IMouseOver 
	{
		private var _info:BagItemInfo;
		public function ShopOver() 
		{
			// constructor code
		}
		
		public function itemMouseOver(e:ItemEvent):void
		{
			_info = e.Param.currentTarget.info;
			if (_info) {
				if (_info.template) {
				ToolTipManager.getInstance().show(Event(e.Param).currentTarget as DisplayObject, _info);
				}
			}
		}

	}
	
}

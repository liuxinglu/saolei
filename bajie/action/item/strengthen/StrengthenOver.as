package bajie.action.item.strengthen 
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
	
	public class StrengthenOver implements IMouseOver 
	{
		private var _e:ItemEvent;
		private var _info:BagItemInfo;
		public function StrengthenOver() 
		{
			// constructor code
		}
		
		public function itemMouseOver(e:ItemEvent):void
		{
			_info = e.Param.currentTarget.info;
			
			if (_info) {
				if (_info.type == GoodsType.EQUIP || _info.type == GoodsType.WEAPON) {
				
				}
				ToolTipManager.getInstance().show(Event(e.Param).currentTarget as DisplayObject, _info);
			}
			
			
		}

	}
	
}

package bajie.action.item.email 
{
	import bajie.core.data.bag.BagItemInfo;
	import bajie.interfaces.item.IMouseOver;
	import bajie.ui.email.EmailItem;
	import flash.events.MouseEvent;
	import bajie.events.ItemEvent;
	import bajie.manager.tick.ToolTipManager;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import bajie.core.data.GlobalData;
	import bajie.events.ParamEvent;
	import bajie.constData.GoodsType;
	
	public class EmailItemOver implements IMouseOver 
	{
		private var item:EmailItem;
		private var _info:BagItemInfo;
		public function EmailItemOver() 
		{
			// constructor code
		}
		
		public function itemMouseOver(e:ItemEvent):void
		{
			item = e.Param.currentTarget;
			_info = e.Param.currentTarget.info;
			if (!_info) return;
			
			if (_info.type == GoodsType.EQUIP || _info.type == GoodsType.WEAPON) {
				if (_info.getInfoOrNot == false) {
					GlobalData.emailInfo.addEventListener(ParamEvent.SHOW_EMAIL_DETAILS, showDetails);
					GlobalData.emailInfo.getEquipEmailDetails(_info.curPage, _info.itemId);
				}else {
					ToolTipManager.getInstance().show(item as DisplayObject, _info);
				}
			}
		}
		public function showDetails(e:ParamEvent):void {
			var o:Object = e.Param;
			GlobalData.emailInfo.itemSp[item.emailListIndex].info.getInfoOrNot = true;
			
			GlobalData.emailInfo.removeEventListener(ParamEvent.SHOW_EMAIL_DETAILS, showDetails);
			
			//写入获取的装备详细信息
			
			
			ToolTipManager.getInstance().show(item as DisplayObject, _info);
		}

	}
	
}

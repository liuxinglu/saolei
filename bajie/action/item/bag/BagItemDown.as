package bajie.action.item.bag {
	import bajie.core.data.bag.BagInfo;
	import bajie.core.data.bag.BagItemInfo;
	import bajie.events.ItemEvent;
	import bajie.interfaces.item.IMouseDown;
	
	public class BagItemDown implements IMouseDown{

		private var _info:BagItemInfo;
		public function BagItemDown(info:BagItemInfo) {
			// constructor code
			_info = info;
		}
		
		public function itemMouseDown(e:ItemEvent):void
		{
			//trace("down");
			e.Param.currentTarget.filters = [];
		}

	}
	
}

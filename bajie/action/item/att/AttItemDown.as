package bajie.action.item.att {
	import bajie.core.data.bag.BagItemInfo;
	import bajie.events.ItemEvent;
	import bajie.interfaces.item.IMouseDown;
	
	public class AttItemDown implements IMouseDown {

		private var _info:BagItemInfo;
		public function AttItemDown(info:BagItemInfo) {
			// constructor code
			_info = info;
		}
		
		public function itemMouseDown(e:ItemEvent):void
		{
			e.Param.currentTarget.filters = [];
		}

	}
	
}

package bajie.action.item.bag {
	import bajie.core.data.bag.BagInfo;
	import bajie.core.data.bag.BagItemInfo;
	import bajie.events.ItemEvent;
	import bajie.interfaces.item.IMouseOut;
	
	public class BagItemOut implements IMouseOut{

		public function BagItemOut(info:BagItemInfo) {
			// constructor code
		}
		
		public function itemMouseOut(e:ItemEvent):void
		{
			e.Param.currentTarget.filters = [];
		}

	}
	
}

package bajie.action.item.shop {
	import bajie.events.ItemEvent;
	import bajie.interfaces.item.IMouseDown;
	
	public class ShopDown implements IMouseDown{

		public function ShopDown() {
			// constructor code
		}
		
		public function itemMouseDown(e:ItemEvent):void
		{
			trace("down");
		}

	}
	
}

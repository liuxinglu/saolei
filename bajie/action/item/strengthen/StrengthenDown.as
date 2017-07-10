package bajie.action.item.strengthen {
	import bajie.events.ItemEvent;
	import bajie.interfaces.item.IMouseDown;
	
	public class StrengthenDown implements IMouseDown{

		public function StrengthenDown() {
			// constructor code
		}
		
		public function itemMouseDown(e:ItemEvent):void
		{
			trace("down");
		}

	}
	
}

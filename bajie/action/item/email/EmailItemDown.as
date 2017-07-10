package bajie.action.item.email {
	import bajie.events.ItemEvent;
	import bajie.interfaces.item.IMouseDown;
	
	public class EmailItemDown implements IMouseDown{

		public function EmailItemDown() {
			// constructor code
		}
		
		public function itemMouseDown(e:ItemEvent):void
		{
			trace("down");
		}

	}
	
}

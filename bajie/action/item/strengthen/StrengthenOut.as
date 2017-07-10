package bajie.action.item.strengthen {
	import bajie.interfaces.item.IMouseOut;
	import bajie.events.ItemEvent;
	
	public class StrengthenOut implements IMouseOut{

		public function StrengthenOut() {
			// constructor code
		}
		
		public function itemMouseOut(e:ItemEvent):void
		{
			trace("out");
		}

	}
	
}

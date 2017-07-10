package bajie.action.item.email {
	import bajie.interfaces.item.IMouseOut;
	import bajie.events.ItemEvent;
	
	public class EmailItemOut implements IMouseOut{

		public function EmailItemOut() {
			// constructor code
		}
		
		public function itemMouseOut(e:ItemEvent):void
		{
			trace("out");
		}

	}
	
}

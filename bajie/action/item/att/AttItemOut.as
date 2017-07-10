package bajie.action.item.att {
	import bajie.interfaces.item.IMouseOut;
	import bajie.events.ItemEvent;
	
	public class AttItemOut implements IMouseOut{

		public function AttItemOut() {
			// constructor code
		}
		
		public function itemMouseOut(e:ItemEvent):void
		{
			e.Param.currentTarget.filters = [];
		}

	}
	
}

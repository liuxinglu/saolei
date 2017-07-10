package bajie.action.item.skill {
	import bajie.interfaces.item.IMouseOut;
	import bajie.events.ItemEvent;
	
	public class SkillItemOut implements IMouseOut{

		public function SkillItemOut() {
			// constructor code
		}
		
		public function itemMouseOut(e:ItemEvent):void
		{
			trace("out");
		}

	}
	
}

package bajie.action.item.skill {
	import bajie.events.ItemEvent;
	import bajie.interfaces.item.IMouseDown;
	
	public class SkillItemDown implements IMouseDown{

		public function SkillItemDown() {
			// constructor code
		}
		
		public function itemMouseDown(e:ItemEvent):void
		{
			trace("down");
		}

	}
	
}

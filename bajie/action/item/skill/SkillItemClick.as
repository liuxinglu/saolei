package bajie.action.item.skill {
	import bajie.interfaces.item.IClick;
	import flash.events.MouseEvent;
	import bajie.events.ItemEvent;
	import bajie.core.data.GlobalData;
	
	public class SkillItemClick implements IClick{
		

		public function SkillItemClick() {
			// constructor code
		}
		
		public function itemClick(e:ItemEvent):void
		{
			var o:Object = e.Param.currentTarget.index;
			//GlobalData.emailInfo.sendMailProps();
			
		}
		
	}
	
}

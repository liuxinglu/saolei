package bajie.action.item.email {
	import bajie.interfaces.item.IClick;
	import flash.events.MouseEvent;
	import bajie.events.ItemEvent;
	import bajie.core.data.GlobalData;
	
	public class EmailItemClick implements IClick{
		
		public function EmailItemClick() {
			// constructor code
		}
		
		public function itemClick(e:ItemEvent):void
		{
			var _info:Object = e.Param.currentTarget.info;
			if(_info)
				GlobalData.emailInfo.sendMailProps(_info.curPage,_info.itemId);
		}
		
	}
	
}

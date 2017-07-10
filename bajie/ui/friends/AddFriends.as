package bajie.ui.friends 
{
	import flash.display.MovieClip;
	import bajie.core.data.GlobalAPI;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import bajie.utils.module.SetModuleUtils;
	import bajie.core.data.GlobalData;
	import bajie.constData.ModuleType;

	/**
	 * ...
	 * @author azjune
	 */
	public class AddFriends extends MovieClip 
	{
		private var ui:*;
		public function AddFriends() 
		{
			ui = GlobalAPI.loaderAPI.getObjectByClassPath("addFriendPan");
			addChild(ui);
			initEvent();
		}
		private function initEvent():void {
			ui.txt_name.restrict = "^ ";
			
			ui.btn_submit.addEventListener(MouseEvent.CLICK, submit);
			ui.btn_cancel.addEventListener(MouseEvent.CLICK, removeMC);
			ui.btn_close.addEventListener(MouseEvent.CLICK, removeMC);
		}
		private function submit(e:MouseEvent):void {
			var _name:String = ui.txt_name.text;
			if (_name.length>0) {
				GlobalData.friendsInfo.addFriend(0, _name);
				removeMC();
			}
		}
		private function removeMC(e:Event = null):void {
			ui.btn_submit.removeEventListener(MouseEvent.CLICK, submit);
			ui.btn_cancel.removeEventListener(MouseEvent.CLICK, removeMC);
			ui.btn_close.removeEventListener(MouseEvent.CLICK, removeMC);
			
			ui = null;
			SetModuleUtils.removeModule(this,ModuleType.ADD_FRIEND);
		}
	}

}
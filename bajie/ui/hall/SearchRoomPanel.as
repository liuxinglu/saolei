package bajie.ui.hall
{
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.utils.module.SetModuleUtils;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.FocusEvent;
	import bajie.ui.Room;
	import bajie.constData.ModuleType;
	
	public class SearchRoomPanel extends MovieClip
	{
		private static var _rom:SearchRoomPanel;
		private static var _searchRoom:*;
		private var passwordEnable:Boolean = false;
		public static function getInstance():SearchRoomPanel
		{
			if(_rom == null)
				_rom = new SearchRoomPanel();
			return _rom;
		}
		
		public function SearchRoomPanel()
		{
			_searchRoom = GlobalAPI.loaderAPI.getObjectByClassPath("searchRoomPanel");
			addChild(_searchRoom);
			initEvent();
		}
		
		private function initEvent():void
		{
			_searchRoom.passwordCheckBox.right.visible = passwordEnable;
			_searchRoom.password.mouseEnabled = passwordEnable;
			
			_searchRoom.closeBtn.addEventListener(MouseEvent.CLICK, closeBtnClickHandler);
			
			_searchRoom.roomName.addEventListener(FocusEvent.FOCUS_IN, roomNameFocusInHandler);
			
			_searchRoom.passwordCheckBox.addEventListener(MouseEvent.CLICK, passwordCheckBoxClickHandler);
			_searchRoom.password.mouseEnabled = false;
			
			_searchRoom.submitBtn.addEventListener(MouseEvent.CLICK, submitBtnClickHandler);
			_searchRoom.cancelBtn.addEventListener(MouseEvent.CLICK, cancelBtnClickHandler);
		}
		
		private function removeEvent():void
		{
			_searchRoom.closeBtn.removeEventListener(MouseEvent.CLICK, closeBtnClickHandler);
			
			_searchRoom.roomName.removeEventListener(FocusEvent.FOCUS_IN, roomNameFocusInHandler);
			
			_searchRoom.passwordCheckBox.removeEventListener(MouseEvent.CLICK, passwordCheckBoxClickHandler);
			
			_searchRoom.submitBtn.removeEventListener(MouseEvent.CLICK, submitBtnClickHandler);
			_searchRoom.cancelBtn.removeEventListener(MouseEvent.CLICK, cancelBtnClickHandler);
		}
		
		//关闭按钮------------------------------------begin-----
		private function closeBtnClickHandler(e:MouseEvent):void
		{
			removeEvent();
			SetModuleUtils.removeModule(this, ModuleType.SEARCH_ROOM);
		}
		//关闭按钮------------------------------------end-------
		
		
		private function roomNameFocusInHandler(e:FocusEvent):void
		{
			_searchRoom.roomName.setSelection(_searchRoom.roomName.selectionBeginIndex, _searchRoom.roomName.selectionEndIndex);
		}
		
		//复选框按钮-----------------------------------begin--------
		private function passwordCheckBoxClickHandler(e:MouseEvent):void
		{
			passwordEnable = !passwordEnable;
			_searchRoom.passwordCheckBox.right.visible = passwordEnable;
			_searchRoom.password.mouseEnabled = passwordEnable;
			if (!passwordEnable)_searchRoom.password.text = "";
		}
		//复选框按钮--------------------------------------end----------
		
		//确定
		private function submitBtnClickHandler(e:MouseEvent):void
		{
			if(_searchRoom.roomName.text == "" || _searchRoom.roomName.text == null)
			{
				return;
			}
			else
			{
				GlobalData.hallInfo.searchRoom(_searchRoom.roomName.text, _searchRoom.password.text);	
				closeBtnClickHandler(e);
			}
			
		}
		
		private function cancelBtnClickHandler(e:MouseEvent):void
		{
			closeBtnClickHandler(e);
		}
	}
}
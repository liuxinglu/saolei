package bajie.ui.hall
{
	import bajie.core.data.GlobalData;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class RoomItem extends MovieClip
	{
		public function RoomItem()
		{
			this.gotoAndStop(1);
			initEvent();
		}
		
		private function initEvent():void
		{
			this.addEventListener(MouseEvent.CLICK, thisClickHandler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_OVER, thisOverHandler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_OUT, thisOutHandler, false, 0, true);
		}
		
		private function thisClickHandler(e:MouseEvent):void
		{
			GlobalData.hallInfo.enterRoom(int(e.currentTarget.roomId.text));
		}
		
		public function removeEvent():void
		{
			this.removeEventListener(MouseEvent.CLICK, thisClickHandler);
			this.removeEventListener(MouseEvent.MOUSE_OVER, thisOverHandler);
			this.removeEventListener(MouseEvent.MOUSE_OUT, thisOutHandler);
		}
		
		private var _tmpRoomId:String = "";
		private var _tmpRoomName:String = "";
		private var _tmpRoomMode:String = "";
		private var _tmpMapName:String = "";
		private var _tmpPeopNum:String = "";
		private var _tmpIsFight:Boolean = false;
		private var _tmpHasPwd:Boolean = false;
		private function thisOverHandler(e:MouseEvent):void
		{
			_tmpRoomId = roomId.text;
				_tmpRoomName = roomName.text;
				_tmpMapName = mapName.text;
				_tmpRoomMode = mode.text;
				_tmpPeopNum = peopNum.text;
				_tmpIsFight = isFight.visible;
				_tmpHasPwd = hasPassword.visible;
			this.gotoAndStop(2);
		}
		
		private function thisOutHandler(e:MouseEvent):void
		{
			this.gotoAndStop(1);
			roomId.text = _tmpRoomId;
			roomName.text = _tmpRoomName;
			mapName.text = _tmpMapName;
			mode.text = _tmpRoomMode;
			peopNum.text = _tmpPeopNum;
			isFight.visible = _tmpIsFight;
			hasPassword.visible = _tmpHasPwd;
		}
	}
}
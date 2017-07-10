package bajie.ui 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import bajie.core.data.GlobalData;
	
	/**
	 * ...
	 * @author azjune
	 */
	public class ChatPanel extends MovieClip 
	{
		private static var _chat:ChatPanel;
		public function ChatPanel() 
		{
			initMC();
		}
		public static function getInstance():ChatPanel {
			if (_chat == null)_chat = new ChatPanel();
			return _chat;
		}
		private function initMC():void {
			this.x = 2;
			this.y = 435;
			sendBtn.addEventListener(MouseEvent.CLICK, sendHandler);
		}
		private function sendHandler(e:MouseEvent):void
		{
			GlobalData.chatInfo.delMessage();
		}
	}

}
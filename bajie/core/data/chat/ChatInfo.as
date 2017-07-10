package bajie.core.data.chat {
	import flash.events.EventDispatcher;
	import bajie.ui.ChatPanel;
	
	public class ChatInfo extends EventDispatcher{
		private var index:int = 0;
		public function ChatInfo() {
			// constructor code
		}
		public function showProtocolMessage(s:String):void
		{
			try{
				ChatPanel.getInstance().txt.htmlText += index++ + "+" + s + "<br/>";
			}
			catch(e:Error)
			{
				
			}
		}
		
		public function delMessage():void
		{
			ChatPanel.getInstance().txt.htmlText = "";
		}
	}
	
}

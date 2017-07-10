package bajie.core.data.toppanel {
	import flash.events.EventDispatcher;
	import bajie.core.data.GlobalAPI;
	
	public class TopPanelInfo extends EventDispatcher
	{
		private var index:int = 0;

		public function TopPanelInfo() {
			// constructor code
		}
		
		public function showProtocolMessage(s:String):void
		{
			try{
				GlobalAPI.main.topPanel.txt.htmlText += index++ + "+" + s + "<br/>";
			}
			catch(e:Error)
			{
				
			}
		}
		
		public function delMessage():void
		{
			GlobalAPI.main.topPanel.txt.htmlText = "";
		}

	}
	
}

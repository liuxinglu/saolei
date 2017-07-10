package bajie.ui.menu {
	import flash.display.SimpleButton;
	import flash.text.TextField;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class MenuButton extends MovieClip
	{

		public var menuText:TextField;
		public function MenuButton() {
			// constructor code
			menuText = new TextField;
			menuText.x = 2;
			menuText.y = 2;
			menuText.mouseEnabled = false;
			addChild(menuText);
			this.buttonMode = true;
			this.gotoAndStop(1);
			initEvent();
		}
		
		private function initEvent():void
		{
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			this.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		public function removeEvent():void
		{
			this.removeEventListener(MouseEvent.CLICK, clickHandler);
			this.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			this.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
		}
		
		private function mouseOutHandler(e:MouseEvent):void
		{
			this.gotoAndStop(3);
		}
		
		private function mouseOverHandler(e:MouseEvent):void
		{
			this.gotoAndStop(2);
		}
		
		private function clickHandler(e:MouseEvent):void
		{
			this.gotoAndStop(1);
		}

	}
	
}

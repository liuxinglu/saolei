package bajie.ui.menu 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import bajie.ui.PopMenu;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author azjune
	 */
	public class PopMenuGroup extends MovieClip 
	{
		private var menus:Array;
		private var menuString:Array = [];
		public function PopMenuGroup() 
		{
			
		}
		public function addMenu(...arg):void {
			if (menus) {
				removeMenu();
			}
			menuString = arg;
			menus = [];
			initMC();
			
		}
		private function initMC():void {
			var len:int = menuString.length;
			for (var i:int = 0; i < len;i++ ) {
				var menu:PopMenu = new PopMenu();
				this.addChild(menu);
				menu.txt.text = menuString[i];
				menu.y = 23 * i;
				menus.push(menu);
			}
		}
		public function removeMC():void {
			menus = null;
			menuString = null;
			parent.removeChild(this);
		}
		private function removeMenu():void {
			if (!menus) return;
			var len:int = menus.length;
			for (var i:int = 0; i < len;i++ ) {
				removeChild(menus[i]);
			}
			menus = null;
		}
		public function getMenu(str:String):PopMenu {
			if (!menus) return null;
			var len:int = menus.length;
			for (var i:int = 0; i < len;i++ ) {
				if(menus[i].txt.text == str)return menus[i];
			}
			return null;
		}
	}

}
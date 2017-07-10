package bajie.ui.friends 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import bajie.core.data.GlobalAPI;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author azjune
	 */
	public class FriendList extends MovieClip 
	{
		private var mc:*;
		private var _friendId:int = 0;
		private var _icon:Loader;
		public function FriendList() 
		{
			mc = GlobalAPI.loaderAPI.getObjectByClassPath("friendsList");
			addChild(mc);
		}
		public function updateInfo(o:Object):void {
			try {
				//好友名字
				mc.txt_name.text = o.name;
				//好友等级
				mc.txt_level.text = o.level;
			}catch (err:Error) {
				trace(err);
				//好友名字
				mc.txt_name.text = "未知目标";
				//好友等级
				mc.txt_level.text = "0";
			}
			
			//好友性别
			mc.mc_sex.gotoAndStop(1);
			
			
			_icon = new Loader();
			if (o.avatar) {
				var urlReq:URLRequest = new URLRequest(o.avatar);
				_icon.load(urlReq);
				_icon.x = _icon.y = 6;
				_icon.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			}
		}
		private function completeHandler(e:Event):void {
			mc.addChild(_icon);
			_icon.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			_icon.content.width = _icon.content.height = 30;
		}
		public function get friendName():String {
			return mc.txt_name.text;
		}
		public function getfrendId():int {
			return _friendId;
		}
		public function removeMC():void {
			_icon.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			_icon = null;
			mc == null;
		}
	}

}
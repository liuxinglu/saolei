package bajie.core.proxy
{
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.socket.SocketInfo;
	
	public class LoginSocketProxy
	{
		public static function loginSocket(info:SocketInfo):void
		{
			GlobalAPI.socketManager.setSocket(info,successHandler,errorHandler);
		}
		
		private static function successHandler():void
		{
			trace("success");
		}
		private static function errorHandler():void
		{
			trace("LoginSocketProxy:error");
		}
	}

}
package bajie.core.data.socketHandler.login 
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.events.BajieDispatcher;
	import bajie.events.ParamEvent;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.core.data.dataFormat.JSONObject;

	/**
	玩家进入游戏， 获得玩家id等基本信息，开始发送心跳包
	*/
	public class LoginEnterGameSocketHandler extends BaseSocketHandler
	{
		public function LoginEnterGameSocketHandler(handlerData:Object = null) 
		{
			// constructor code
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.ACCOUNT_GETIN;
		}
		
		override public function handlePackage():void
		{
			handComplete();
		}
		
		public static function enter(sessionKey:String):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.ACCOUNT_GETIN);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.name = "chenpeng";
			oo.pass = "111111";
			jo.setObject(ProtocolType.ACCOUNT_GETIN, "1.0", "abcd1256892582", oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}

	}
	
}
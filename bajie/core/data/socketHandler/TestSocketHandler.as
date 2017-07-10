package bajie.core.data.socketHandler
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.events.BajieDispatcher;
	import bajie.events.ParamEvent;
	import bajie.interfaces.socket.IPackageOut;
	
	import flash.utils.ByteArray;
	import bajie.constData.CommonConfig;

	public class TestSocketHandler extends BaseSocketHandler
	{
		public function TestSocketHandler(handlerData:Object = null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.ACCOUNT_GETIN;
		}
		
		override public function handlePackage():void
		{
			//trace(_data.readString());
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{//登录失败
				trace("登陆失败");
			}
			else
			{
				BajieDispatcher.getInstance().dispatchEvent(new ParamEvent(BajieDispatcher.LOGIN_SUCCESS, o));
			}
			
			handComplete();
		}
		//{protocol:10001,version:1.0,number:”abcd1256892582”,body:”{name:’chenpeng’,pass:’111111’}”}
		//{"body":{"pass":"liuxinglu","name":"liuxinglu"},"protocol":10001,"version":"1.0","number":"abcd1256892582"}
		public static function send(key:String = null):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.ACCOUNT_GETIN);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			
			if(key == null)
			{
				oo.name = GlobalData.tmpUserName;///// "liuxinglu";
				oo.pass = GlobalData.tmpPassword;///// "111111";
				jo.setObject(ProtocolType.ACCOUNT_GETIN, GlobalData.version.toString(), "abcd1256892582", oo);
			}
			else
			{
				oo.session_key = key;
				jo.setObject(ProtocolType.ACCOUNT_GETIN, GlobalData.version.toString(), GlobalData.numberCode, oo);
			}
			
			pkg.writeString(jo.getString());
			
			//trace(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}
}
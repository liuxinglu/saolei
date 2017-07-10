package bajie.core.data.socketHandler.clearmines
{
	import bajie.constData.CommonConfig;
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.utils.SaoLeiTool;
	
	public class GamePropMinEffectSocketHandler extends BaseSocketHandler
	{
		public function GamePropMinEffectSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.GAME_PROP_MIN_EFFECT;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				GlobalData.alertInfo.pureAlert(o);
			}
			else
			{
				
			}
			handComplete();
		}
		
		public static function send():void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.GAME_PROP_MIN_EFFECT);
			var jo:JSONObject = new JSONObject;
			var oo:Object = new Object;
			jo.setObject(ProtocolType.GAME_PROP_MIN_EFFECT, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}
}
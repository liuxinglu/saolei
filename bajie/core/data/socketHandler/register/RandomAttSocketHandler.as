package bajie.core.data.socketHandler.register
{
	import bajie.constData.CommonConfig;
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.events.BajieDispatcher;
	import bajie.events.ParamEvent;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.utils.SaoLeiTool;
	
	public class RandomAttSocketHandler extends BaseSocketHandler
	{
		public function RandomAttSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.RANDOM_ATT;
		}
		
		/**
		 * {"protocol":1006,"version":1,"number":"20121210185704",
		 * "body":"{\"playerid\":1,\"name\":\"\",\"sex\":1,\"energy\":16,\"lucky\":4,\"dexterity\":10,\"ip\":\"\"}"}
		 * */
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				return;
			}
			BajieDispatcher.getInstance().dispatchEvent(new ParamEvent( BajieDispatcher.GET_ATT_SUCCESS, o));
			handComplete();
		}
		
		
		public static function send(playerid:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.RANDOM_ATT);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object();
			oo.playerid = playerid;
			oo.body = "";
			jo.setObject(ProtocolType.RANDOM_ATT, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}
}
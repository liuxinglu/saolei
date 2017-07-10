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
	
	public class ClearMinesSocketHandler extends BaseSocketHandler
	{
		public function ClearMinesSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.GAME_DIG_GRID;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("错了哦");
			}
			handComplete();
		}
		
		//{"protocol":1062,"version":1,"number":"20130110134835","body":"{\"playerid\":1,\"teamid\":1001,\"map\":1,\"mode\":1,\"grade\":0,\"index\":1,\"key\":1}"}
		public static function send(roomid:String, key:int, index:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.GAME_DIG_GRID);
			var jo:JSONObject = new JSONObject;
			var oo:Object = new Object;
			oo.teamid = roomid;
			oo.key = key;
			oo.index = index;
			jo.setObject(ProtocolType.GAME_DIG_GRID, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}
}
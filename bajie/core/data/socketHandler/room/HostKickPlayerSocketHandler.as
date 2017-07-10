package bajie.core.data.socketHandler.room
{
	import bajie.constData.CommonConfig;
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.utils.SaoLeiTool;
	
	public class HostKickPlayerSocketHandler extends BaseSocketHandler
	{
		public function HostKickPlayerSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.HOST_KICK_PLAYER;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{//失败
			}
			handComplete();
		}
		
		//\"playerid\":1,\"teamid\":1001,\"map\":1,\"mode\":1,\"grade\":0,\"index\":2}"}
		public static function send(playerid:int, roomid:int,index:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.HOST_KICK_PLAYER);
			var jo:JSONObject = new JSONObject;
			var oo:Object = new Object();
			oo.playerid = playerid;
			oo.teamid = roomid;
			oo.index = index;
			jo.setObject(ProtocolType.HOST_KICK_PLAYER, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}
}
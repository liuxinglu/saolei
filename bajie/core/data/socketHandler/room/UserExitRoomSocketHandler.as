package bajie.core.data.socketHandler.room {
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.utils.SaoLeiTool;
	import bajie.constData.CommonConfig;
	
	public class UserExitRoomSocketHandler extends BaseSocketHandler{

		public function UserExitRoomSocketHandler(handlerData:Object=null) {
			// constructor code
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.USER_EXIT_ROOM;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				
			}
			else
			{
				GlobalData.hallInfo.exitRoomInfo(o);
			}
			handComplete();
		}
		
		//{\"playerid\":1,\"teamid\":1001,\"map\":1,\"mode\":1,\"grade\":1,\"index\":1}
		public static function send(playerId:int, roomId:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.USER_EXIT_ROOM);
			var jo:JSONObject = new JSONObject;
			var oo:Object = new Object;
			oo.playerid = playerId;
			oo.teamid = roomId;
			jo.setObject(ProtocolType.USER_EXIT_ROOM, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}

	}
	
}

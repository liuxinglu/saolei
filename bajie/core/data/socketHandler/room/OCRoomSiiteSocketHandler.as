package bajie.core.data.socketHandler.room
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.utils.SaoLeiTool;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	
	public class OCRoomSiiteSocketHandler extends BaseSocketHandler
	{
		public function OCRoomSiiteSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.OPEN_CLOSE_ROOM_SITE;
		}
		
		override public function handlePackage():void
		{
			handComplete();
		}
		
		public static function send(playerid:int, roomid:int,index:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.OPEN_CLOSE_ROOM_SITE);
			var jo:JSONObject = new JSONObject;
			var oo:Object = new Object();
			oo.playerid = playerid;
			oo.teamid = roomid;
			oo.index = index;
			jo.setObject(ProtocolType.OPEN_CLOSE_ROOM_SITE, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}
}
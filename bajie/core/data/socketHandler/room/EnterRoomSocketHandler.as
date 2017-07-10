package bajie.core.data.socketHandler.room
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.utils.SaoLeiTool;
	
	public class EnterRoomSocketHandler extends BaseSocketHandler
	{
		public function EnterRoomSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.USER_ENTER_ROOM;
		}
		
		/**
		 *{"protocol":1014,"
		 * version":1,"
		 * number":"20121212110121",
		 * "body":"{"
		 * 	teamid":1636,"name":"测试房间","level":3,"map":2,"shut":false,"mode":1,"grade":3,"
		 * member":"[{"playerid":3,"name":"r","sex":1,"avatar":"http://share.bajiegame.com/dungeon/images/job11.png","level":1,"vip":0,"energy":0,"lucky":0,"dexterity":0,"exp":0,"skill":0,"index":0,"ready":1,"captain":1,"me":1,"weapon":0}]"
		  ,"close":"[1,1,1,0]"}"}
		 * 
		 */		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			GlobalData.hallInfo.getRoomInfo(o);
			handComplete();
		}
		
		public static function send(roomid:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.USER_ENTER_ROOM);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object();
			oo.teamid = roomid;
			jo.setObject(ProtocolType.USER_ENTER_ROOM, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}
}
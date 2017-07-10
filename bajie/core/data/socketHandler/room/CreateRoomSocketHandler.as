package bajie.core.data.socketHandler.room
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.room.vo.RoomVO;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.utils.SaoLeiTool;
	
	public class CreateRoomSocketHandler extends BaseSocketHandler
	{
		public function CreateRoomSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.USER_CREATE_ROOM;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			handComplete();
		}
		
		/**
		 *{"protocol":1013,"version":1,"number":"20121211153707","
		 * body":"{\"guid\":\"00000000-0000-0000-0000-000000000000\",\"
		 * playerid\":1,\"teamid\":0,\"name\":\"测试房间\",\
		 * "level\":1,\"captain\":0,\"password\":\"\",\"map\":2,\"number\":3,\"
		 * count\":1,\"shut\":0,\"doing\":0,\"mode\":1,\"grade\":3}"} 
		 * @param vo
		 * 
		 */		
		public static function send(vo:RoomVO):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.USER_CREATE_ROOM);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object();
			oo.playerid = vo.playerid;
			oo.name = vo.name;
			oo.password = vo.password;
			oo.map = vo.map;
			oo.mode = vo.mode;
			oo.grade = vo.grade;
			jo.setObject(ProtocolType.USER_CREATE_ROOM, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}
}
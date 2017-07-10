package bajie.core.data.socketHandler.room
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.utils.SaoLeiTool;
	
	public class UserRCStateSocketHandler extends BaseSocketHandler
	{
		public function UserRCStateSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.USER_READY_CANCEL;
		}
		
		override public function handlePackage():void
		{
			handComplete();
		}
		
		public static function send(roomId:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.USER_READY_CANCEL);
			var jo:JSONObject = new JSONObject;
			var oo:Object = new Object;
			oo.teamid = roomId;
			jo.setObject(ProtocolType.USER_READY_CANCEL, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}
}
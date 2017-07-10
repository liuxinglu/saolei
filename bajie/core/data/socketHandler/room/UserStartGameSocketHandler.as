package bajie.core.data.socketHandler.room
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.utils.SaoLeiTool;
	import bajie.constData.CommonConfig;
	
	public class UserStartGameSocketHandler extends BaseSocketHandler
	{
		public function UserStartGameSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.HOST_START_GAME;
		}
		
		//{playerid:232, plate:{row:6, col:6, content:abcdefgh},self:{},rival:{}}
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("获取战斗界面信息失败");
			}
			else
			{
				GlobalData.fightInfo.enterBattleField(o);
			}
			handComplete();
		}
		
		//{\"playerid\":1,\"teamid\":1001,\"map\":1,\"mode\":1,\"grade\":0,\"index\":0}
		public static function send(roomId:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.HOST_START_GAME);
			var jo:JSONObject = new JSONObject;
			var oo:Object = new Object;
			oo.teamid = roomId;
			jo.setObject(ProtocolType.HOST_START_GAME, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
		
	}
}
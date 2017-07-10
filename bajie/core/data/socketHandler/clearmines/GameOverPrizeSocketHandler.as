package bajie.core.data.socketHandler.clearmines {
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.constData.ProtocolType;
	import bajie.constData.CommonConfig;
	import bajie.core.data.GlobalData;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.utils.SaoLeiTool;
	
	public class GameOverPrizeSocketHandler extends BaseSocketHandler
	{

		public function GameOverPrizeSocketHandler(handData:Object = null) {
			// constructor code
			super(handData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.GAME_OVER_PRIZE;
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
		
		public static function send(roomid:String, key:String, index:String):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.GAME_OVER_PRIZE)
			var jo:JSONObject = new JSONObject;
			var oo:Object = new Object;
			oo.teamid = roomid;
			oo.key = key;
			oo.index = index;
			jo.setObject(ProtocolType.GAME_OVER_PRIZE, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}

	}
	
}

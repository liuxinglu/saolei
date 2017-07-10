package bajie.core.data.socketHandler.clearmines {
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.constData.ProtocolType;
	import bajie.constData.CommonConfig;
	import bajie.core.data.GlobalData;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.utils.SaoLeiTool;
	
	public class GameOverRankSocketHandler extends BaseSocketHandler{

		public function GameOverRankSocketHandler(handData:Object = null) {
			// constructor code
			super(handData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.GAME_OVER_RANKING;
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
				GlobalData.fightInfo.getRankList(o);
			}
			handComplete();
		}
		
		public static function send():void
		{
			/*var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.GAME_OVER_RANKING);
			var jo:JSONObject = new JSONObject;
			var oo:Object = new Object;
			jo.setObject(ProtocolType.GAME_OVER_RANKING, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);*/
		}

	}
	
}

package bajie.core.data.socketHandler.player {
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.core.data.GlobalAPI;
	import bajie.constData.ProtocolType;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.GlobalData;
	import bajie.utils.SaoLeiTool;
	import bajie.constData.CommonConfig;
	
	public class GetSimplePlayerInfoSocketHandler extends BaseSocketHandler{

		public function GetSimplePlayerInfoSocketHandler(handData:Object = null) {
			// constructor code
			super(handData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.GET_SIMPLE_PLAYER_INFO;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				return;
			}
			GlobalData.playerInfo.getSimplePlayerInfo(o);
			handComplete();
		}
		
		public static function send():void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.GET_SIMPLE_PLAYER_INFO);
			var jo:JSONObject = new JSONObject;
			var oo:Object = new Object;
			oo.playerid = GlobalData.playerid;
			jo.setObject(ProtocolType.GET_SIMPLE_PLAYER_INFO, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
		

	}
	
}

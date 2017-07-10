package bajie.core.data.socketHandler.main 
{
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalData;
	import bajie.core.data.GlobalAPI;
	import bajie.utils.SaoLeiTool;
	import bajie.constData.CommonConfig;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.core.data.dataFormat.JSONObject;
	
	/**
	 * ...
	 * @author azjune
	 */
	public class GetOnlineAwardSocketHandler extends BaseSocketHandler 
	{
		
		public function GetOnlineAwardSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.GET_ONLINE_AWARD;
		}
		
		override public function handlePackage():void
		{
			//trace("设置步骤3");
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("获取在线奖励失败");
			}
			else
			{
				//
			}
			handComplete();
		}
		
		public static function send(playid:uint):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.GET_ONLINE_AWARD);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			jo.setObject(ProtocolType.GET_ONLINE_AWARD, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}
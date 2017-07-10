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
	public class UpdateOnlineTimeSocketHandler extends BaseSocketHandler 
	{
		
		public function UpdateOnlineTimeSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.UPDATE_ONLINE_TIME;
		}
		
		override public function handlePackage():void
		{
			//trace("设置步骤3");
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("更新在线时间失败");
			}
			else
			{
				//
			}
			handComplete();
		}
		
		public static function send(playid:uint):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.UPDATE_ONLINE_TIME);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			jo.setObject(ProtocolType.UPDATE_ONLINE_TIME, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}
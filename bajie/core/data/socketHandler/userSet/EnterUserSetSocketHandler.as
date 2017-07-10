package bajie.core.data.socketHandler.userSet 
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
	public class EnterUserSetSocketHandler extends BaseSocketHandler 
	{
		
		public function EnterUserSetSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.GET_USER_SETTING;
		}
		
		override public function handlePackage():void
		{
			//trace("设置步骤3");
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("获取用户配置失败");
			}
			else
			{
				GlobalData.userSetInfo.completeUserSet(o);
			}
			handComplete();
		}
		
		public static function send(playid:uint):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.GET_USER_SETTING);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			oo.body = "";
			jo.setObject(ProtocolType.GET_USER_SETTING, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
			//trace("设置步骤2");
		}
	}

}
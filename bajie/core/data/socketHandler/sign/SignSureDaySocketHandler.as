package bajie.core.data.socketHandler.sign 
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
	public class SignSureDaySocketHandler extends BaseSocketHandler 
	{
		
		public function SignSureDaySocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.SIGN_SURE_DAY;
		}
		
		override public function handlePackage():void
		{
			//trace("设置步骤3");
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("用户签到失败");
			}
			else
			{
				
			}
			handComplete();
		}
		
		public static function send(playid:uint):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.SIGN_SURE_DAY);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			jo.setObject(ProtocolType.SIGN_SURE_DAY, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}
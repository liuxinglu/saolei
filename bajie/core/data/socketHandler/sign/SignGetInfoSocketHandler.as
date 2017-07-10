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
	public class SignGetInfoSocketHandler extends BaseSocketHandler 
	{
		
		public function SignGetInfoSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.GET_SIGN_INFO;
		}
		
		override public function handlePackage():void
		{
			//trace("设置步骤3");
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("获取签到信息");
			}
			else
			{
				GlobalData.signInfo.updateDate(o);
			}
			handComplete();
		}
		
		public static function send(playid:uint,year:int,month:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.GET_SIGN_INFO);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			oo.year = year;
			oo.month = month;
			jo.setObject(ProtocolType.GET_SIGN_INFO, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}
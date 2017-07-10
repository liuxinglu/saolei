package bajie.core.data.socketHandler.email 
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
	public class GetEmailListSocketHandler extends BaseSocketHandler 
	{
		
		public function GetEmailListSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.GET_MAIL_LIST;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("获取邮件列表失败");
			}
			else
			{
				GlobalData.emailInfo.showEmailList(o);
			}
			handComplete();
		}
		
		public static function send(playid:uint,index:int,type:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.GET_MAIL_LIST);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			oo.index = index;
			oo.type = type;
			jo.setObject(ProtocolType.GET_MAIL_LIST, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}
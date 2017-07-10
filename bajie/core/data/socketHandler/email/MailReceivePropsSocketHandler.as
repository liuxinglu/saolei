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
	public class MailReceivePropsSocketHandler extends BaseSocketHandler 
	{
		
		public function MailReceivePropsSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.MAIL_RECEIVE_PROPS;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("邮件获得道具失败");
			}
			else
			{
				GlobalData.emailInfo.showEmailList(o);
			}
			handComplete();
		}
		
		public static function send(playid:uint,index:int,bigidx:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.MAIL_RECEIVE_PROPS);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			oo.index = index;
			oo.bigidx = bigidx;
			jo.setObject(ProtocolType.MAIL_RECEIVE_PROPS, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}
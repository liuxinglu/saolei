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
	public class GetEquipEmailDetailsSocketHandler extends BaseSocketHandler 
	{
		
		public function GetEquipEmailDetailsSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.GET_EQUIPT_EMAIL_DETAILS;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("邮件获得装备详细信息失败");
			}
			else
			{
				GlobalData.emailInfo.showEmailDetails(o);
			}
			handComplete();
		}
		
		public static function send(playid:uint,index:int,bigidx:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.GET_EQUIPT_EMAIL_DETAILS);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			oo.index = index;
			oo.bigidx = bigidx;
			jo.setObject(ProtocolType.GET_EQUIPT_EMAIL_DETAILS, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}
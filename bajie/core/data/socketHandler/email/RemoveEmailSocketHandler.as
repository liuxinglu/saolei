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
	public class RemoveEmailSocketHandler extends BaseSocketHandler 
	{
		
		public function RemoveEmailSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.REMOVE_EMAIL;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("删除邮件失败");
			}
			else
			{
				GlobalData.emailInfo.showEmailList(o);
			}
			handComplete();
		}
		
		public static function send(playid:uint,index:int,bigidx:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.REMOVE_EMAIL);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			oo.index = index;
			oo.bigidx = bigidx;
			jo.setObject(ProtocolType.REMOVE_EMAIL, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}
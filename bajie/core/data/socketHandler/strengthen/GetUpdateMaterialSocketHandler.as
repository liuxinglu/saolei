package bajie.core.data.socketHandler.strengthen 
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
	public class GetUpdateMaterialSocketHandler extends BaseSocketHandler 
	{
		
		public function GetUpdateMaterialSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.GET_UPGRADE_MATERIAL;
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
				GlobalData.strengthenInfo.showUpdateMaterial(o);
			}
			handComplete();
		}
		
		public static function send(playid:uint,index:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.GET_UPGRADE_MATERIAL);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			oo.index = index;
			jo.setObject(ProtocolType.GET_UPGRADE_MATERIAL, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}
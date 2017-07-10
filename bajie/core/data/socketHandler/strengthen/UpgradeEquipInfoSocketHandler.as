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
	public class UpgradeEquipInfoSocketHandler extends BaseSocketHandler 
	{
		
		public function UpgradeEquipInfoSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.UPGRADE_EQUIPT_INFO;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				trace("装备升级失败");
			}
			else
			{
				GlobalData.strengthenInfo.showUpgradeInfo(o);
			}
			handComplete();
		}
		
		public static function send(playid:uint,idx:int,index:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.UPGRADE_EQUIPT_INFO);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			oo.idx = idx;
			oo.index = index;
			jo.setObject(ProtocolType.UPGRADE_EQUIPT_INFO, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}
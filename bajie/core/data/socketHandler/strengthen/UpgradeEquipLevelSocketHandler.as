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
	public class UpgradeEquipLevelSocketHandler extends BaseSocketHandler 
	{
		
		public function UpgradeEquipLevelSocketHandler() 
		{
			
		}
		override public function getCode():int
		{
			return ProtocolType.UPGRADE_EQUIPT_LEVEL;
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
				//
			}
			handComplete();
		}
		
		public static function send(playid:uint,idx:int,luckynumber:int,brustnumber:int,index:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.UPGRADE_EQUIPT_LEVEL);
			var jo:JSONObject = new JSONObject();
			var oo:Object = new Object;
			oo.playerid = playid;
			oo.idx = idx;
			oo.luckynumber = luckynumber;
			oo.brustnumber = brustnumber;
			oo.index = index;
			jo.setObject(ProtocolType.UPGRADE_EQUIPT_LEVEL, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}

}
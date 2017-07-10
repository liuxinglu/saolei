package bajie.core.data.socketHandler.bag {
	import bajie.constData.CommonConfig;
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalData;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.utils.SaoLeiTool;
	
	public class GetEquipDetailInfoSocketHandler extends BaseSocketHandler{

		public function GetEquipDetailInfoSocketHandler(handData:Object = null) {
			// constructor code
			super(handData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.GET_EQUIP_DETAILS_INFO;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			if(o.code != CommonConfig.SUCCESS)
			{
				return;
			}
			else
			{
				GlobalData.bagInfo.getEquipDetailInfo(o);
			}
			handComplete();
		}
		
		public static function send(itemid:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.GET_EQUIP_DETAILS_INFO);
			var jo:JSONObject = new JSONObject;
			var oo:Object = new Object();
			oo.playerid = GlobalData.playerid;
			oo.bigidx = itemid;
			jo.setObject(ProtocolType.GET_EQUIP_DETAILS_INFO, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}

	}
	
}

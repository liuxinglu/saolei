package bajie.core.data.socketHandler.bag
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.utils.SaoLeiTool;
	
	public class EquipEquipSocketHandler extends BaseSocketHandler
	{
		public function EquipEquipSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.EQUIP_EQUIP;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			handComplete();
		}
		
		/**
		 * @param itemid 装备id
		 * @param index 装备拖放格子索引
		 */		
		public static function send(itemid:int, index:int = 0):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.EQUIP_EQUIP);
			var jo:JSONObject= new JSONObject;
			var oo:Object = new Object;
			oo.playerid = GlobalData.playerid;
			oo.idx = itemid;
			if(index != 0)
				oo.index = index;
			jo.setObject(ProtocolType.EQUIP_EQUIP, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}
}
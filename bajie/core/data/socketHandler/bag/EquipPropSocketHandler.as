package bajie.core.data.socketHandler.bag
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.utils.SaoLeiTool;
	
	public class EquipPropSocketHandler extends BaseSocketHandler
	{
		public function EquipPropSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.EQUIP_PROP;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			handComplete();
		}
		
		/** 
		 * @param itemid 道具id
		 * @param index 道具拖放格子索引1-4(菜单装备不用传)
		 * 
		 */		
		public static function send(itemid:int, index:int=0):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.EQUIP_PROP);
			var jo:JSONObject = new JSONObject;
			var oo:Object = new Object;
			oo.playerid = GlobalData.playerid;
			oo.idx = itemid;
			if(index != 0)
				oo.index = index;
			jo.setObject(ProtocolType.EQUIP_PROP, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}
}
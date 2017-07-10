package bajie.core.data.socketHandler.bag
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.utils.SaoLeiTool;
	
	public class SortBagFashionSocketHandler extends BaseSocketHandler
	{
		public function SortBagFashionSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.SORT_BAG_FASHION;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			handComplete();
		}
		
		public static function send():void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.SORT_BAG_FASHION);
			var jo:JSONObject = new JSONObject;
			var oo:Object = new Object;
			oo.playerid = GlobalData.playerid;
			jo.setObject(ProtocolType.SORT_BAG_FASHION, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}
}
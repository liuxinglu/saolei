package bajie.core.data.socketHandler.bag
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.utils.SaoLeiTool;
	
	public class GetBagPropSocketHandler extends BaseSocketHandler
	{
		public function GetBagPropSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.GET_BAG_PROP;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			GlobalData.bagInfo.getBagPropInfo(o);
			handComplete();
		}
		
		public static function send(curPage:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.GET_BAG_PROP);
			var jo:JSONObject = new JSONObject;
			var oo:Object = new Object;
			oo.playerid = GlobalData.playerid;
			if(curPage <= 0)
				curPage = 1;
			oo.index = curPage;
			jo.setObject(ProtocolType.GET_BAG_PROP, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}
}
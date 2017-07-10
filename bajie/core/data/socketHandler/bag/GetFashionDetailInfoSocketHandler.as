package bajie.core.data.socketHandler.bag
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.utils.SaoLeiTool;
	import bajie.constData.CommonConfig;
	
	public class GetFashionDetailInfoSocketHandler extends BaseSocketHandler
	{
		public function GetFashionDetailInfoSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.GET_FASHION_DETAILS_INFO;
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
				GlobalData.bagInfo.getFashionDetailInfo(o);
			}
			handComplete();
		}
		
		public static function send(itemId:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.GET_FASHION_DETAILS_INFO);
			var jo:JSONObject = new JSONObject;
			var oo:Object = new Object;
			oo.playerid = GlobalData.playerid;
			oo.bagidx = itemId;
			jo.setObject(ProtocolType.GET_FASHION_DETAILS_INFO, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}
}
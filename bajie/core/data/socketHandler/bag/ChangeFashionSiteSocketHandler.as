package bajie.core.data.socketHandler.bag
{
	import bajie.constData.ProtocolType;
	import bajie.core.data.GlobalAPI;
	import bajie.core.data.GlobalData;
	import bajie.core.data.dataFormat.JSONObject;
	import bajie.core.data.socket.BaseSocketHandler;
	import bajie.interfaces.socket.IPackageOut;
	import bajie.utils.SaoLeiTool;
	
	public class ChangeFashionSiteSocketHandler extends BaseSocketHandler
	{
		public function ChangeFashionSiteSocketHandler(handlerData:Object=null)
		{
			super(handlerData);
		}
		
		override public function getCode():int
		{
			return ProtocolType.CHANGE_FASHION_SITE;
		}
		
		override public function handlePackage():void
		{
			var o:Object = _data.readObj();
			handComplete();
		}
		
		/**
		 * @param fromIndex 开始拖动的背包索引
		 * @param toIndex 结束拖动的背包索引
		 */		
		public static function send(fromIndex:int, toIndex:int):void
		{
			var pkg:IPackageOut = GlobalAPI.socketManager.getPackageOut(ProtocolType.CHANGE_FASHION_SITE);
			var jo:JSONObject = new JSONObject;
			var oo:Object = new Object;
			oo.fromindex = fromIndex;
			oo.toindex = toIndex;
			jo.setObject(ProtocolType.CHANGE_FASHION_SITE, GlobalData.version.toString(), SaoLeiTool.getCurrentTime(), oo);
			pkg.writeString(jo.getString());
			GlobalAPI.socketManager.send(pkg);
		}
	}
}